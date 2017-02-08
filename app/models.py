from django.db import models
from django.utils import timezone
# Create your models here.



class Meta(models.Model):
    """Meta"""
#    meta_id = models.AutoField(primary_key=True)
    org_dbname = models.CharField('DB Name', max_length=255)
    import_dbname = models.CharField('New DB Name', max_length=255)
    #sqlname = models.CharField('SQL File Name', max_length=255, blank=True)
    metafile= models.FileField('Meta File', upload_to='metafiles/', default='')
    created_at = models.DateTimeField(default=timezone.now)
    imported_yn= models.BooleanField(default=False)

    def __str__(self):
        return self.import_dbname


class Replay(models.Model):
    """Replay Query"""
    meta = models.ForeignKey(Meta, verbose_name='meta', related_name='replay_list')
#    replay_id= models.AutoField(primary_key=True)
    sql_text = models.TextField('SQL TEXT', blank=True)
    tested_yn = models.BooleanField(default=False)
    suceeded_yn = models.BooleanField(default=False)
    logs = models.TextField('LOGS', blank=True)

    def __str__(self):
        return self.sql_text

class ReplayFile(models.Model):
    """Replay Query File"""
    meta = models.ForeignKey(Meta, verbose_name='meta', related_name='file_list')
    description = models.CharField(max_length=255, blank=True)
    replayfile = models.FileField('Replay File', upload_to='replayfiles/', default='')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.description
