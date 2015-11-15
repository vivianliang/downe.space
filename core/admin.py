from django.contrib import admin

from .models import Event
from .models import Category

admin.site.register(Event)
admin.site.register(Category)
