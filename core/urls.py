from django.urls import path
from . import views

urlpatterns = [
    # ── AUTH (Navegador Web) ──────────────────────────────────────────────────
    path('', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),

    # ── VISTAS WEB (Dashboard) ────────────────────────────────────────────────
    path('administrativo/', views.administrativo, name='administrativo'),
    path('gerencia/', views.gerencia, name='gerencia'),
    path('estilista/', views.estilista_view, name='estilista_dashboard'),

    # ── API COMPARTIDA / FLUTTER (Datos JSON) ─────────────────────────────────
    path('api/clientes/', views.api_clientes, name='api_clientes'),
    path('api/clientes/<int:pk>/', views.api_cliente_detalle, name='api_cliente_detalle'),
    
    path('api/mascotas/', views.api_mascotas, name='api_mascotas'),
    path('api/mascotas/<int:pk>/', views.api_mascota_detalle, name='api_mascota_detalle'),
    
    path('api/citas/', views.api_citas, name='api_citas'),
    path('api/citas/<int:pk>/', views.api_cita_detalle, name='api_cita_detalle'),
    
    # Acción específica de Flutter (Estilista)
    path('api/actualizar_estado_cita/<int:pk>/', views.api_actualizar_estado_cita, name='api_actualizar_estado_cita'),

    path('api/pagos/', views.api_pagos, name='api_pagos'),
    path('api/servicios/', views.api_servicios, name='api_servicios'),
    path('api/catalogos/', views.api_catalogos, name='api_catalogos'),

    # ── API GERENCIA ──────────────────────────────────────────────────────────
    path('api/gerencia/dashboard/', views.api_gerencia_dashboard, name='api_gerencia_dashboard'),
    path('api/gerencia/empleados/', views.api_ger_empleados, name='api_ger_empleados'),
    path('api/gerencia/empleados/<int:pk>/', views.api_ger_empleado_detalle, name='api_ger_empleado_detalle'),
    path('api/gerencia/catalogos/', views.api_ger_catalogos, name='api_ger_catalogos'),
    path('api/gerencia/reporte/ingresos/', views.api_ger_reporte_ingresos, name='api_ger_reporte_ingresos'),
    path('api/gerencia/reporte/citas/', views.api_ger_reporte_citas, name='api_ger_reporte_citas'),
    path('api/gerencia/reporte/empleados/', views.api_ger_reporte_empleados, name='api_ger_reporte_empleados'),

    # ── API MÓVIL (Login) ─────────────────────────────────────────────────────
    path('api/login/', views.api_login, name='api_login'),
]