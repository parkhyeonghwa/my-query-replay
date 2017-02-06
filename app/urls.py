from django.conf.urls import url
from app import views

urlpatterns  =  [
    url(r'^meta/$' ,  views.meta_list , name='meta_list' ),    # list
    url(r'^meta/add/$' ,  views.meta_add, name='meta_add' ),    # add
    url(r'^meta/import/(?P<meta_id>\d+)$', views.meta_import ,  name = 'meta_import' ),    # import
    url(r'^meta/del/(?P<meta_id>\d+)/$', views.meta_del, name='meta_del'),   # delete
 # Query Replay
    url(r'^replay/(?P<meta_id>\d+)/$', views.ReplayList.as_view(), name='replay_list'),
    url(r'^replay/upload/(?P<meta_id>\d+)/$', views.replay_upload, name='replay_upload'),
    url(r'^replay/add/(?P<meta_id>\d+)/$', views.replay_edit, name='replay_add'),
    url(r'^replay/mod/(?P<meta_id>\d+)/(?P<replay_id>\d+)/$', views.replay_edit, name='replay_mod'),
    url(r'^replay/run/(?P<meta_id>\d+)/(?P<replay_id>\d+)/$', views.replay_run, name='replay_run'),
    url(r'^replay/replay_run_all/(?P<meta_id>\d+)/$', views.replay_run_all, name='replay_run_all'),
    url(r'^replay/del/(?P<meta_id>\d+)/(?P<replay_id>\d+)/$', views.replay_del, name='replay_del'),

]
