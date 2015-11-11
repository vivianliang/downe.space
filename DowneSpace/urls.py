from django.conf.urls import include, patterns, url
from django.contrib import admin

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'DowneSpace.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^api/', include('core.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url('', include('social.apps.django_app.urls', namespace='social'))
)
