import os
from pathlib import Path
import pymysql

# Soporte para MySQL/MariaDB
pymysql.version_info = (2, 2, 1, "final", 0)
pymysql.install_as_MySQLdb()

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = 'django-insecure-tu-llave-secreta-aqui'

DEBUG = True

# PERMITIR TODO para que Flutter (emulador/celular) conecte sin problemas
ALLOWED_HOSTS = ['*']

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    # --- LIBRERÍAS PARA FLUTTER ---
    'rest_framework',      
    'corsheaders',         
    
    # --- TU APP ---
    'core',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware', # DEBE IR ARRIBA DE TODO
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

# PERMISOS PARA FLUTTER (CORS)
CORS_ALLOW_ALL_ORIGINS = True 

ROOT_URLCONF = 'estetica_canina.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')], # Para tus archivos HTML
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# BASE DE DATOS UNIFICADA
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'estetica_canina',   
        'USER': 'root',
        'PASSWORD': '',
        'HOST': 'localhost', # O '127.0.0.1'
        'PORT': '3306',
        'OPTIONS': {
            'charset': 'utf8mb4',
        }
    }
}

# CONFIGURACIÓN REGIONAL (Tijuana)
LANGUAGE_CODE = 'es-mx'
TIME_ZONE = 'America/Tijuana'
USE_I18N = True
USE_TZ = False 

STATIC_URL = '/static/'
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]
STATIC_ROOT = BASE_DIR / 'staticfiles'

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'