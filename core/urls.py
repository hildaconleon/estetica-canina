from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('administrativo/', views.administrativo, name='administrativo'),
    
    # --- Dashboard de Estilistas ---
    path('estilista/', views.estilista_view, name='estilista_dashboard'),

    # --- APIs para Clientes ---
    path('api/clientes/', views.api_clientes, name='api_clientes'),
    path('api/clientes/<int:pk>/', views.api_cliente_detalle, name='api_cliente_detalle'),

    # --- APIs para Mascotas ---
    path('api/mascotas/', views.api_mascotas, name='api_mascotas'),
    path('api/mascotas/<int:pk>/', views.api_mascota_detalle, name='api_mascota_detalle'),

    # --- APIs para Citas (Incluye el cambio de estado) ---
    path('api/citas/', views.api_citas, name='api_citas'),
    path('api/citas/<int:pk>/', views.api_cita_detalle, name='api_cita_detalle'),
    path('api/citas/<int:pk>/estado/', views.api_actualizar_estado_cita, name='api_actualizar_estado_cita'),

    # --- APIs de Pagos, Servicios y Catálogos ---
    path('api/pagos/', views.api_pagos, name='api_pagos'),
    path('api/servicios/', views.api_servicios, name='api_servicios'),
    path('api/catalogos/', views.api_catalogos, name='api_catalogos'),
]