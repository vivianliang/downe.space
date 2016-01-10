# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib.auth import get_user_model
from django.db import migrations, models


def create_admin(apps, schema_editor):
  User = get_user_model()
  User.objects.create_user(username='Admin')


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
      migrations.RunPython(create_admin)
    ]
