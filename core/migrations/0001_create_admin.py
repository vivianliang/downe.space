# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib.auth import get_user_model
from django.db import migrations, models
from django.conf import settings


def create_admin(apps, schema_editor):
  User = get_user_model()
  User.objects.create_user(username='Admin')


class Migration(migrations.Migration):
    dependencies = [
      migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
      migrations.RunPython(create_admin)
    ]
