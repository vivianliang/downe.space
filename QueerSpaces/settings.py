"""
Django settings for QueerSpaces project.

For more information on this file, see
https://docs.djangoproject.com/en/1.7/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.7/ref/settings/
"""

from os import environ
from os.path import abspath, dirname, join, normpath

import dj_database_url

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = normpath(join(dirname(abspath(__file__)), '..', '..'))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.7/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '5ctu%4a&m@rc86l8j3928x1t8b19f5kjr+-q)l*4y&agi&17iu'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

TEMPLATE_DEBUG = True

ALLOWED_HOSTS = ['*']


# Application definition

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'localflavor',
    'rest_framework',
    'debug_toolbar',
    'social.apps.django_app.default',
    'core'
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)


ROOT_URLCONF = 'QueerSpaces.urls'

WSGI_APPLICATION = 'QueerSpaces.wsgi.application'

# Python Social Auth
# http://psa.matiasaguirre.net/docs/index.html
SOCIAL_AUTH_LOGIN_REDIRECT_URL = '/'

SOCIAL_AUTH_FACEBOOK_KEY = environ.get('SOCIAL_AUTH_FACEBOOK_KEY')
SOCIAL_AUTH_FACEBOOK_SECRET = environ.get('SOCIAL_AUTH_FACEBOOK_SECRET')

AUTHENTICATION_BACKENDS = (
  'social.backends.facebook.FacebookOAuth2',
)

# Database
# https://docs.djangoproject.com/en/1.7/ref/settings/#databases
DATABASES = {}
environ.setdefault('DATABASE_URL', 'postgres://127.0.0.1:5432/%s' % environ.get('USER', 'postgres'))

DATABASES['default'] = dj_database_url.config()
DATABASES['default']['ENGINE'] = 'djschema'
DATABASES['default']['CONN_MAX_AGE'] = 60
DATABASES['default']['OPTIONS'] = {'sslmode': 'allow'}
print 'DATABASE_URL: %s' % DATABASES['default']['NAME']

# Internationalization
# https://docs.djangoproject.com/en/1.7/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True

# honor the 'X-Forwarded-Proto' header for request.is_secure()
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.7/howto/static-files/
STATIC_ROOT = 'staticfiles'
STATIC_URL  = '/static/'

APP_ROOT = 'appfiles/app'
APP_URL = '/app'
