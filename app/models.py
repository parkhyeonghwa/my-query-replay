from django.db import models
from django.utils import timezone
# Create your models here.



class Meta(models.Model):
    """Meta"""
    org_dbname = models.CharField('DB Name', max_length=255)
    import_dbname = models.CharField('New DB Name', max_length=255)
    metafile= models.FileField('Meta File', upload_to='metafiles/', default='')
    created_at = models.DateTimeField(default=timezone.now)
    imported_yn= models.BooleanField(default=False)

    def __str__(self):
        return self.import_dbname


class Replay(models.Model):
    """Replay Query"""
    meta = models.ForeignKey(Meta, verbose_name='meta', related_name='replay_list')
    sql_text = models.TextField('SQL TEXT', blank=True)
    tested_yn = models.BooleanField(default=False)
    suceeded_yn = models.BooleanField(default=False)
    logs = models.TextField('LOGS', blank=True)

    def __str__(self):
        return self.sql_text


ReplayFile_Types = (
    ('pt-query-digest','pt-query-digest'), # split with \G
    ('query-analyzer', 'query-analyzer'), # split with new line
    ('sql','sql') #split with ;\n
)


class ReplayFile(models.Model):
    """Replay Query File"""
    meta = models.ForeignKey(Meta, verbose_name='meta', related_name='file_list')
    description = models.CharField(max_length=255, blank=True)
    filetype=models.CharField(max_length=30, choices=ReplayFile_Types, default='')
    replayfile = models.FileField('Replay File', upload_to='replayfiles/', default='')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.description
