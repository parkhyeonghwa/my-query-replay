from django.http  import  HttpResponse
from django.shortcuts import render, get_object_or_404, redirect
from django.views.generic.edit import FormMixin
from django.views.generic.list import ListView

from app.models import  Meta, Replay, ReplayFile
from app.forms import MetaForm, ReplayForm, UploadFileForm
import subprocess, os, sys, re
from subprocess import Popen, PIPE, STDOUT
import modules
from django.conf import settings
from django.db import connections


# Create your views here.


# imported_meta_list 목록보기
def  meta_list ( request ) :
    "" "Meta list" ""
    meta_list = Meta.objects.all().order_by('id')
    return render(request,
                  'app/meta_list.html',
                  {'meta_list': meta_list})

def  meta_add(request):
    """Meta add"""
    if request.method == 'POST':
        form = MetaForm(request.POST, request.FILES)
        if form.is_valid():
            meta = form.save(commit=False)
            meta.save()
            return redirect('app:meta_list')
    else:    # GET
        form = MetaForm()
    return render(request,  'app/meta_add.html', {
        'form': form
    })


def  meta_del(request, meta_id):
    """Meta delete"""
    meta = get_object_or_404(Meta, pk=meta_id)
    if meta.imported_yn == True:
        try:
            cursor = connections['default'].cursor()
            # drop the imported database
            cursor.execute('drop database if exists %s' % meta.import_dbname)
        finally:
            cursor.close ()
    ifile = os.path.join(settings.MEDIA_ROOT,os.path.basename(meta.metafile.name))
    ofile = os.path.join(settings.MEDIA_ROOT,os.path.dirname(meta.metafile.name),meta.import_dbname,'meta',os.path.basename(meta.metafile.name))

    # Check if the file exists and remove
    os.path.exists(ifile) and os.path.isfile(ifile) and os.remove(ifile)
    os.path.exists(ofile) and os.path.isfile(ifile) and os.remove(ofile)

    meta.delete()

    return redirect('app:meta_list')


def  meta_import (request, meta_id) :
    """Meta import"""
    if meta_id:   # meta_id 지정
        meta = get_object_or_404(Meta, pk=meta_id)
        # extract
        script_filename = os.path.join(settings.SCRIPT_DIR,'schema_extraction.py')
        command = ['python',script_filename, '-i', os.path.join(settings.MEDIA_ROOT,meta.metafile.name), '-d', meta.org_dbname, '-n', meta.import_dbname]
        p = Popen(command,  stdout=PIPE, stderr=STDOUT)
        out = p.stdout.read()
        print ("Schema_extraction: %s" % out)

        # import
        ofile = os.path.join(settings.MEDIA_ROOT,os.path.dirname(meta.metafile.name),meta.import_dbname,'meta',os.path.basename(meta.metafile.name))

        print (ofile)
        if os.path.exists(ofile):
            print ("extract file exists")
            f = open(ofile)
            database = settings.DATABASES['testdb']

            command = ['mysql','-u',database['USER'],'-p%s'%database['PASSWORD'],'-h',database['HOST'],'-P',database['PORT'],database['NAME']]

            try:
                p = Popen(command, stdout=PIPE, stdin=f, stderr=PIPE)
                out, err = p.communicate()

                if err:
                    print("out",out)
                    print("err",err)
                else:
                    print("meta update")
                    meta.imported_yn=1
                    meta.save()
            except OSError as e:
                print ("OSError > ",e.errno)
                print ("OSError > ",e.strerror)
                print ("OSError > ",e.filename)
                return redirect('app:meta_list')
            except:
                print ("Unkown Error > ",sys.exc_info()[0])
                return redirect('app:meta_list')
        else:
            print ("extract file not extist")

    return redirect('app:meta_list')


class ReplayList(ListView):
    """Replay List"""
    context_object_name='replay_list'
    template_name='app/replay_list.html'
    paginate_by = 100  # 1페이지당 100건씩 페이징

    def get(self, request, *args, **kwargs):
        meta = get_object_or_404(Meta, pk=kwargs['meta_id'])
        replay_list = meta.replay_list.all().order_by('id')
        self.object_list = replay_list
        context = self.get_context_data(object_list=self.object_list, meta=meta)
        return self.render_to_response(context)


class ReplayList_NG(ListView):
    """Replay NG List"""
    context_object_name='replay_list'
    template_name='app/replay_list_ng.html'
    paginate_by = 100
    def get(self, request, *args, **kwargs):
        meta = get_object_or_404(Meta, pk=kwargs['meta_id'])
        replay_list_ng = meta.replay_list.all().filter(succeeded_yn=False).order_by('id')
        self.object_list = replay_list_ng
        context = self.get_context_data(object_list=self.object_list, meta=meta)
        return self.render_to_response(context)



def replay_upload(request, meta_id):
    meta = get_object_or_404(Meta, pk=meta_id)
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():
            replayfile = form.save(commit=False)
            replayfile.meta = meta
            replayfile.save()
            sql_load(meta_id,replayfile.id)
            return redirect('app:replay_list', meta_id=meta_id)
        else:
            print(form)
    else:
        form = UploadFileForm()
    return render(request,
                  'app/replay_upload.html',
                  dict(form=form, meta_id=meta_id))


def removeComments(inputFileName, outputFileName):
    # Remove Comments and SET commands, Remove a whitespace in aggregate function.
    inf = open(inputFileName, "r")
    outf = open(outputFileName, "w")

#    outf.write(inf.readline())
    for line in inf:
        if not line.strip():
            continue #Empty line
        elif line.lstrip().startswith("#") and line.lstrip().startswith("SET") and line.lstrip().startswith("administrator command") and line.lstrip().startswith("SELECT @") and line.isspace():
            continue #skip this line
        else:
            outf.write(line)

    inf.close()
    outf.close()

def sql_load(meta_id,replayfile_id):
    # load
    meta = get_object_or_404(Meta, pk=meta_id)
    replayfile = get_object_or_404(ReplayFile, pk=replayfile_id)
    rfile = os.path.join(settings.MEDIA_ROOT,replayfile.replayfile.name)
    nrfile =  os.path.join(settings.MEDIA_ROOT,replayfile.replayfile.name+'_new.sql')
    removeComments(rfile,nrfile)
    if os.path.exists(nrfile):
        print ("replay file exists")
        if replayfile.filetype == "pt-query-digest" :
            with open(nrfile) as f:
                for line in f.read().split('\G'):
                    #print(line)
                    replay = Replay()
                    replay.sql_text=line+';'
                    replay.meta = meta
                    replay.save()

        elif replayfile.filetype == "query-analyzer" :
            with open(nrfile) as f:
                for line in f.read().split('\n'):
                    #print(line)
                    replay = Replay()
                    replay.sql_text=line+';'
                    replay.meta = meta
                    replay.save()
        else:
            with open(nrfile) as f:
                for line in f.read().split(';\n'):
                    #print(line)
                    replay = Replay()
                    replay.sql_text=line+';'
                    replay.meta = meta
                    replay.save()



def replay_edit(request, meta_id, replay_id=None):
  """Replay Query Edit"""
  meta = get_object_or_404(Meta, pk=meta_id)
  if replay_id: #edit
        replay = get_object_or_404(Replay, pk=replay_id)
  else:         #add
        replay = Replay()

  if request.method == 'POST':
      form = ReplayForm(request.POST, instance=replay)
      if form.is_valid():
          replay = form.save(commit=False)
          replay.meta = meta
          replay.save()
          return redirect('app:replay_list', meta_id=meta_id)
  else:
      form = ReplayForm(instance=replay)

  return render(request,
                'app/replay_edit.html',
                dict(form=form, meta_id=meta_id, replay_id=replay_id))

def replay_run(request, meta_id, replay_id):
    """Replay Query Run"""
    meta = get_object_or_404(Meta, pk=meta_id)
    replay = get_object_or_404(Replay, pk=replay_id)
    database = settings.DATABASES['testdb']
    tfile = os.path.join(settings.MEDIA_ROOT,'replayfiles',meta.import_dbname,replay_id+'.sql')
    os.makedirs(os.path.dirname(tfile), exist_ok=True)
    tf = open(tfile, 'w')
    rep = {'?' : '0', 'COUNT (' : 'COUNT(', 'MAX (' : 'MAX (', 'MIN (' : 'MIN(','CONCAT (' : 'CONCAT(', 'SUM (' : 'SUM(', 'NOW (':'NOW('}
    rep = dict((re.escape(k), v) for k, v in rep.items())
    pattern = re.compile("|".join(rep.keys()))
    sqlline = pattern.sub(lambda m: rep[re.escape(m.group(0))], replay.sql_text)
    print(sqlline)
    tf.write(sqlline)

    #tf.write(replay.sql_text.replace('?','0'))
    tf.close()
    #mysqltest
    command = ['mysqltest','-u',database['USER'],'-p%s'%database['PASSWORD'],'-h',database['HOST'],'-P',database['PORT'],meta.import_dbname,'-x',tfile]
    try:
        p = Popen(command, stdout=PIPE, stderr=PIPE)
        out, err = p.communicate()
        if err:
            replay.logs=out+err
            replay.tested_yn=1
            replay.succeeded_yn=0
            replay.save()
        else:
            replay.logs=out
            replay.tested_yn=1
            replay.succeeded_yn=1
            replay.save()
    except OSError as e:
        print ("OSError > ",e.errno)
        print ("OSError > ",e.strerror)
        print ("OSError > ",e.filename)
        return redirect('app:meta_list')
    except:
        print ("Unkown Error > ",sys.exc_info()[0])
        return redirect('app:replay_list', meta_id=meta_id)

    return redirect('app:replay_list', meta_id=meta_id)

def replay_del(request, meta_id, replay_id):
    """Replay Query Delete"""
    meta = get_object_or_404(Meta, pk=meta_id)
    replay = get_object_or_404(Replay, pk=replay_id)
    tfile = os.path.join(settings.MEDIA_ROOT,'replayfiles',meta.import_dbname,replay_id+'.sql')
    os.path.exists(tfile) and os.path.isfile(tfile) and os.remove(tfile)
    replay.delete()
    return redirect('app:replay_list', meta_id=meta_id)



def replay_run_all(request,meta_id):
    meta = get_object_or_404(Meta, pk=meta_id)

    if request.method == "POST":
        list_of_ids = request.POST.getlist('ids[]')
        print (list_of_ids)

        for id in list_of_ids:
            replay_run('POST',meta_id, id)
    print('done')

    return redirect('app:replay_list', meta_id=meta_id)


def replay_delete_all(request,meta_id):
    meta = get_object_or_404(Meta, pk=meta_id)
    if request.method == "POST":
        list_of_ids = request.POST.getlist('ids[]')
        print (list_of_ids)
        for id in list_of_ids:
            replay_del('POST',meta_id, id)
    print('done')

    return redirect('app:replay_list', meta_id=meta_id)
