from django.db import models


class Meta(models.Model):
    """Meta"""
    meta_id = models.AutoField(primary_key=True).
    org_dbname = models.CharField('DB Name', max_length=255)
    import_dbname = models.CharField('Import DB Name', max_length=255)
    sqlname = models.CharField('SQL File Name', max_length=255, blank=True)
    dba = models.CharField('DBA Name', max_length=255, blank=True)
    created_at = models.DateTimeField(default=timezone.now)
  

    def __str__(self):
        return self.import_dbname


#class Impression(models.Model):
#    """감상"""
#    book = models.ForeignKey(Book, verbose_name='책', related_name='impressions')
#    comment = models.TextField('댓글', blank=True)
#
#    def __str__(self):
#        return self.comment
