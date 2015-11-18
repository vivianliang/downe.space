from django.contrib import admin

from .models import Category, Event

admin.site.register(Event)
admin.site.register(Category)
