from django.http  import  HttpResponse
from django.shortcuts import render, get_object_or_404, redirect
from django.views.generic.list import ListView

from app.models import  Meta, Replay, ReplayFile
from app.forms import MetaForm, ReplayForm, UploadFileForm
import subprocess, os, sys, re
from subprocess import Popen, PIPE, STDOUT
import modules
from django.conf import settings
from django.db import connections
# from django.core.files.storage import FileSystemStorage

# Create your views here.


# Imaginary function to handle an uploaded file.

# Create your views here.

# imported_meta_list 목록보기
def  meta_list ( request ) :
    "" "Meta list" ""
    meta_list = Meta.objects.all().order_by('id')
    #return HttpResponse ( 'Meta list' )
    return render(request,
                  'app/meta_list.html',
                  {'meta_list': meta_list})

def  meta_add(request):
    """Meta add"""
    if request.method == 'POST':
        form = MetaForm(request.POST, request.FILES)  # POST된 request 자료에서 양식을 작성
        if form.is_valid():    # 폼 검증
            meta = form.save(commit=False)
            meta.save()
            return redirect('app:meta_list')
    else:    # GET 할 때
        form = MetaForm()  # meta form
    return render(request,  'app/meta_add.html', {
        'form': form
    })
    # return render(request, 'app/meta_add.html', dict(form=form, meta_id=meta_id))
def  meta_del(request, meta_id):
    """Meta delete"""
    meta = get_object_or_404(Meta, pk=meta_id)
    if meta.imported_yn == True:
        # with connections['default'].cursor() as cursor:
        #     cursor.execute("drop database if exists %s" % meta.import_dbname)
        #     row = cursor.fetchone()
        #
        # return row
        try:
            cursor = connections['default'].cursor()
            cursor.execute('drop database if exists %s' % meta.import_dbname)
            #return cursor.fetchall()
        finally:
            cursor.close ()
    ifile = os.path.join(settings.MEDIA_ROOT,os.path.basename(meta.metafile.name))
    ofile = os.path.join(settings.MEDIA_ROOT,os.path.dirname(meta.metafile.name),meta.import_dbname,'meta',os.path.basename(meta.metafile.name))

    # file exist and remove
    os.path.exists(ifile) and os.path.isfile(ifile) and os.remove(ifile)
    os.path.exists(ofile) and os.path.isfile(ifile) and os.remove(ofile)
    # if os.path.exists(ofile):
    #         print ("extract file exists")
    #         f = open(ofile)
    #         database = settings.DATABASES['default']
    #
    #         #print('mysql','-u',database['USER'],'-p',database['PASSWORD'],'-h',database['HOST'],'-P',database['PORT'],database['NAME'])
    #         command = ['mysql','-u',database['USER'],'-p%s'%database['PASSWORD'],'-h',database['HOST'],'-P',database['PORT'],database['NAME']]
    #         #command = "/usr/local/bin/mysql -u%s -p%s -h%s -P%s %s" % (database['USER'],database['PASSWORD'],database['HOST'],database['PORT'],database['NAME'])
    #         print (command)
    #         p = Popen(command, stdout=PIPE, stdin=f, stderr=PIPE)
    #         out, err = p.communicate()
    #         print ("Schema_import: %s" % out)
    #
    # else:
    #         print ("extract file not extist ")
    meta.delete()

    return redirect('app:meta_list')

# def exec_sql_file(cursor, sql_file):
#     print ("\n[INFO] Executing SQL script file: '%s'" % sql_file)
#     statement = ""
#
#     for line in open(sql_file):
#         # if re.match(r'--', line):  # ignore sql comment lines
#         #     continue
#         if not re.search(r'[^-;]+;', line):  # keep appending lines that don't end in ';'
#             statement = statement + line
#         else:  # when you get a line ending in ';' then exec statement and reset for next statement
#             statement = statement + line
#             #print "\n\n[DEBUG] Executing SQL statement:\n%s" % (statement)
#             try:
#                 cursor.execute(statement)
#             except (OperationalError, ProgrammingError) as e:
#                 print ("\n[WARN] MySQLError during execute statement \n\tArgs: '%s'" % (str(e.args)))



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

            #print('mysql','-u',database['USER'],'-p',database['PASSWORD'],'-h',database['HOST'],'-P',database['PORT'],database['NAME'])
            command = ['mysql','-u',database['USER'],'-p%s'%database['PASSWORD'],'-h',database['HOST'],'-P',database['PORT'],database['NAME']]
            #command = ['mysql','-u',database['USER'],'-p','-h',database['HOST'],'-P',database['PORT'],database['NAME']]#,'| sed -e \'$!d\'']

            #command = "/usr/local/bin/mysql -u%s -p%s -h%s -P%s %s" % (database['USER'],database['PASSWORD'],database['HOST'],database['PORT'],database['NAME'])
            # print (command)
            # p = Popen(command, stdout=PIPE, stdin=f, stderr=PIPE)
            # out, err = p.communicate()
            #
            # print ("Schema_import: %s" % out)
            try:
                p = Popen(command, stdout=PIPE, stdin=f, stderr=PIPE)
                #res = subprocess.Popen(['xls','-al','/home'],stdout=subprocess.PIPE);
                out, err = p.communicate()

                if out:
                    print("out",out)
                    print("err",err)
                else:
                    print("meta update")
                    meta.imported_yn=1
                    meta.save()
            #except CalledProcessError as e:
            #   print "CalledError > ",e.returncode
            #   print "CalledError > ",e.output
            except OSError as e:
                print ("OSError > ",e.errno)
                print ("OSError > ",e.strerror)
                print ("OSError > ",e.filename)
                return redirect('app:meta_list')
            except:
                print ("Unkown Error > ",sys.exc_info()[0])
                return redirect('app:meta_list')
#             .name = 'New name'
# >>> b5.save()
            #
            # try:
            #     cursor = connections['default'].cursor()
            #
            #     # exec_sql_file(cursor,ofile)
            #
            #     #cursor.execute('select 1')
            #
            #     for line in open(ofile).read().split(';\n'):
            #         cursor.execute(line)
            #         #connections['default'].commit()
            #     # return cursor.fetchall()
            # finally :
            #   cursor.close ()
            #   connections['default'].close()


            # cursor = connections['default'].cursor()
            # for line in open(ofile).read().split(';\n'):
            #     cursor.execute(line)
        else:
            print ("extract file not extist")

    #    output = subprocess.check_output(['python', 'schema_extraction.py']).decode('utf-8')
    return redirect('app:meta_list')


class ReplayList(ListView):
    """Replay List"""
    context_object_name='replay_list'
    template_name='app/replay_list.html'
    paginate_by = 100  # 1페이지당 2건씩 페이징

    def get(self, request, *args, **kwargs):
        meta = get_object_or_404(Meta, pk=kwargs['meta_id'])
        replay_list = meta.replay_list.all().order_by('id')
        self.object_list = replay_list

        context = self.get_context_data(object_list=self.object_list, meta=meta)
        return self.render_to_response(context)
# #
# def replay_upload(request, meta_id):
#     if request.method == 'POST' and request.FILES['myfile']:
#     #f = request.FILES['replayfile']
#         print ("upload")
#     #     fs = FileSystemStorage()
#     #     filename = fs.save(myfile.name, myfile)
#     #     uploaded_file_url = fs.url(filename)
#     #     return render(request, 'app/replay_upload.html', {
#     #         'uploaded_file_url': uploaded_file_url
#     #     })
#     return render(request, 'app/replay_upload.html', dict(form=form, meta_id=meta_id))


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
    inf = open(inputFileName, "r")
    outf = open(outputFileName, "w")

    outf.write(inf.readline())

    for line in inf:
        if  not line.lstrip().startswith("#") and not line.lstrip().startswith("SET") and not line.lstrip().startswith("administrator command"):
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
        with open(nrfile) as f:
            for line in f.read().replace('\G', ';\n').split(';\n'):
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
    #print (replay.sql_text)
    # cursor = connections['default'].cursor()
    # cursor.execute("USE %s"% meta.import_dbname)
    # try:
    database = settings.DATABASES['testdb']
    tfile = os.path.join(settings.MEDIA_ROOT,'replayfiles',meta.import_dbname,replay_id+'.sql')
    os.makedirs(os.path.dirname(tfile), exist_ok=True)
    tf = open(tfile, 'w')
    tf.write(replay.sql_text)
    # mysqltest -uroot -p import_dbname -x rfile
    tf.close()

    command = ['mysqltest','-u',database['USER'],'-p%s'%database['PASSWORD'],'-h',database['HOST'],'-P',database['PORT'],meta.import_dbname,'-x',tfile]
    try:
        p = Popen(command, stdout=PIPE, stderr=PIPE)
        #res = subprocess.Popen(['xls','-al','/home'],stdout=subprocess.PIPE);
        out, err = p.communicate()
        print("out",out)
        print("err",err)
        if err:
            replay.logs=out+err
            replay.tested_yn=1
            replay.suceeded_yn=0
            replay.save()
        else:
            replay.logs=out
            replay.tested_yn=1
            replay.suceeded_yn=1
            replay.save()
    except OSError as e:
        print ("OSError > ",e.errno)
        print ("OSError > ",e.strerror)
        print ("OSError > ",e.filename)
        return redirect('app:meta_list')
    except:
        print ("Unkown Error > ",sys.exc_info()[0])
        return redirect('app:replay_list', meta_id=meta_id)




    # for line in replay.sql_text.split(';\n'):
    #     #print(line)
    #     # cursor.execute(line)
    #     # res = cursor.fetchall()
    #     # print (res)
    #     # logs=res
    #     # replay.suceeded_yn=1
    #     # replay.save()
    #
    # except:
    #     print ("Error > ",sys.exc_info()[0], sys.exc_info()[1])
    #     logs=sys.exc_info()[1]
    #
    #     return redirect('app:replay_list', meta_id=meta_id)
    # finally :
    #     cursor.close ()
    #     connections['default'].close()
    #     print (logs)
    #     replay.logs=logs
    #     replay.tested_yn=1
    #     replay.save()



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
    #meta_id= request.GET.get('meta_id', None)
    #print(meta_id)
    meta = get_object_or_404(Meta, pk=meta_id)
    #print(meta_id)
    #list_of_ids = request.POST.getlist('run_all_list')
    #print (list_of_ids)
    if request.method == "POST":
        list_of_ids = request.POST.getlist('ids[]')
        print (list_of_ids)
        #replay = Replay.objects.filter(id__in=list_of_ids)
        for id in list_of_ids:
            #print(id)
            replay_run('POST',meta_id, id)
    print('done')

    return redirect('app:replay_list', meta_id=meta_id)



def replay_delete_all(request,meta_id):
    #meta_id= request.GET.get('meta_id', None)
    #print(meta_id)
    meta = get_object_or_404(Meta, pk=meta_id)
    #print(meta_id)
    #list_of_ids = request.POST.getlist('run_all_list')
    #print (list_of_ids)
    if request.method == "POST":
        list_of_ids = request.POST.getlist('ids[]')
        print (list_of_ids)
        #replay = Replay.objects.filter(id__in=list_of_ids)
        for id in list_of_ids:
            #print(id)
            replay_del('POST',meta_id, id)
    print('done')

    return redirect('app:replay_list', meta_id=meta_id)
