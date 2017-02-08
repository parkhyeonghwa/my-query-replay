from django import forms
from django.forms import ModelForm
from app.models import Meta, Replay, ReplayFile



class MetaForm(ModelForm):
    """Meta Form"""
    class Meta:
        model = Meta
        fields = ('org_dbname', 'import_dbname','metafile')
class ReplayForm(ModelForm):
    """Replay Queries"""
    class Meta:
        model = Replay
        fields = ('sql_text', )

class UploadFileForm(ModelForm):
    """Upload Replay Files"""
    class Meta:
        model = ReplayFile
        fields = ('description', 'filetype', 'replayfile', )
