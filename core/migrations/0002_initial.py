# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import bleachfields.bleachtext
import enumfields.fields
from django.conf import settings
from django.db import migrations, models

import core.models.enums.frequency


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('core', '0001_create_admin'),
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', bleachfields.bleachtext.BleachTextField(max_length=64)),
            ],
            options={
                'verbose_name_plural': 'categories',
            },
        ),
        migrations.CreateModel(
            name='Coords',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('lat', models.FloatField()),
                ('lon', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='Event',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', bleachfields.bleachtext.BleachTextField(max_length=512)),
                ('description', bleachfields.bleachtext.BleachTextField(max_length=2048, null=True)),
                ('start', models.DateTimeField()),
                ('end', models.DateTimeField()),
                ('location', bleachfields.bleachtext.BleachTextField(max_length=2048)),
                ('frequency', enumfields.fields.EnumIntegerField(default=0, enum=core.models.enums.frequency.Frequency)),
                ('url', models.URLField(null=True)),
                ('image', models.TextField(null=True)),
                ('contact', models.ForeignKey(related_name='events', to=settings.AUTH_USER_MODEL, null=True)),
            ],
        ),
        migrations.AddField(
            model_name='coords',
            name='event',
            field=models.ForeignKey(related_name='coords', to='core.Event'),
        ),
        migrations.AddField(
            model_name='category',
            name='events',
            field=models.ManyToManyField(related_name='categories', to='core.Event'),
        ),
    ]
