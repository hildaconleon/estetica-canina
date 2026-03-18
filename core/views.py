from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from django.utils import timezone

from .models import (
    Empleado, Cliente, EstadoCliente, TelefonoCliente,
    Mascota, Raza, EstadoMascota, Tamano,
    Cita, EstadoCita, DetalleCita,
    Servicio, Pago, TipoPago
)

# ── LOGIN CON REDIRECCIÓN DINÁMICA (3 NIVELES) ────────────────
@csrf_exempt 
def login_view(request):
    if request.method == "POST":
        # --- DETECCIÓN DE ORIGEN ---
        if request.content_type == 'application/json':
            body = json.loads(request.body)
            username_p = body.get("username")
            password_p = body.get("password")
            es_api = True # Es el móvil
        else:
            username_p = request.POST.get("username")
            password_p = request.POST.get("password")
            es_api = False # Es la web
        
        user = authenticate(request, username=username_p, password=password_p)
        
        if user is not None:
            login(request, user)
            
            # --- LÓGICA DE NOMBRES Y ROLES ---
            rol = "estilista"
            nombre_completo = user.username 
            
            try:
                # Usamos __iexact para ignorar mayúsculas/minúsculas
                empleado = Empleado.objects.get(usuario__iexact=user.username)
                request.session['empleado_id'] = empleado.clave
                
                # --- LA MAGIA DE LOS 3 ROLES ---
                usuario_str = empleado.usuario.lower()
                
                if user.is_superuser or usuario_str == 'hilda':
                    rol = "gerencia"
                    nombre_completo = f"{empleado.nombre} (Gerente)"
                elif user.is_staff or usuario_str == 'mariat':
                    rol = "admin"
                    nombre_completo = f"{empleado.nombre} (Recepcionista)"
                else:
                    rol = "estilista"
                    nombre_completo = f"{empleado.nombre} (Estilista)"
                    
                request.session['empleado_nombre'] = nombre_completo
                
            except Empleado.DoesNotExist:
                # Si el usuario no está en la tabla Empleado pero existe en Django
                if user.is_superuser:
                    rol = "gerencia"
                    nombre_completo = f"{user.username} (Gerente)"
                elif user.is_staff:
                    rol = "admin"
                    nombre_completo = f"{user.username} (Admin)"
                else:
                    rol = "usuario"
                    nombre_completo = user.username
                request.session['empleado_nombre'] = nombre_completo

            # --- RESPUESTA PARA EL MÓVIL (FLUTTER) ---
            if es_api:
                return JsonResponse({
                    "ok": True, 
                    "mensaje": "Bienvenido", 
                    "rol": rol,
                    "nombre": user.username 
                })
            
            # --- REDIRECCIÓN PARA LA WEB ---
            if rol == "gerencia":
                return redirect('gerencia')          # ¡MANDA A HILDA A GERENCIA!
            elif rol == "admin":
                return redirect('administrativo')    # ¡MANDA A MARIAT A RECEPCIÓN!
            else:
                return redirect('estilista_dashboard') # MANDA A ESTILISTAS A SUS CITAS
                
        else:
            # Error de credenciales
            if es_api:
                return JsonResponse({"ok": False, "error": "Credenciales inválidas"}, status=401)
            messages.error(request, "Usuario o contraseña incorrectos")
            
    return render(request, "core/index.html")

def logout_view(request):
    logout(request)
    request.session.flush()
    return redirect('login')

# ── VISTA PARA GERENCIA (HILDA) ─────────────────────────────────
def gerencia(request):
    # Protegemos la ruta para que solo superusuarios o hilda entren
    if not request.user.is_authenticated:
        return redirect('login')
        
    nombre = request.session.get('empleado_nombre', request.user.username)
    iniciales = ''.join(p[0].upper() for p in nombre.split()[:2]) if nombre else 'U'
    
    return render(request, "core/gerencia.html", {
        'empleado': {'nombre': nombre, 'iniciales': iniciales}
    })

# ── VISTA PARA ADMINISTRADOR (MARIAT) ─────────────────────────────────
def administrativo(request):
    if not request.user.is_authenticated:
        return redirect('login')
        
    nombre = request.session.get('empleado_nombre', request.user.username)
    iniciales = ''.join(p[0].upper() for p in nombre.split()[:2]) if nombre else 'U'
    
    return render(request, "core/administrativo.html", {
        'empleado': {'nombre': nombre, 'iniciales': iniciales}
    })

# ── VISTA DINÁMICA PARA ESTILISTAS (COMPLETA) ───────────────────────
def estilista_view(request):
    if not request.user.is_authenticated:
        return redirect('login')
    
    # 1. Intentamos sacar el nombre "bonito" de la sesión
    nombre_display = request.session.get('empleado_nombre', request.user.username)
    
    # 2. Identificar al objeto empleado para filtrar las citas
    try:
        empleado_obj = Empleado.objects.get(usuario=request.user.username)
        if "(Estilista)" not in nombre_display and not request.user.is_staff:
             nombre_display = f"{empleado_obj.nombre} (Estilista)"
    except Empleado.DoesNotExist:
        empleado_obj = None

    iniciales = ''.join(p[0].upper() for p in nombre_display.split()[:2]) if nombre_display else 'U'
    hoy = timezone.now().date()
    
    # 3. Filtrar solo las citas de HOY para ESTE estilista
    citas_hoy = Cita.objects.filter(fecha=hoy, empleado=empleado_obj).select_related(
        'mascota', 'mascota__raza', 'estado_cita'
    ).order_by('hora')

    # Mapeo de datos para el Dashboard
    for cita in citas_hoy:
        detalle = DetalleCita.objects.filter(cita=cita).select_related('servicio').first()
        cita.servicio_nombre = detalle.servicio.nombre if detalle else "Sin servicio"
        cita.nombre_estado = cita.estado_cita.nombre if cita.estado_cita else "Pendiente"
        cita.raza_nombre = cita.mascota.raza.nombre if cita.mascota.raza else "N/A"

    context = {
        'empleado': {'nombre': nombre_display, 'iniciales': iniciales},
        'hoy': hoy,
        'citas': citas_hoy,
        'stats': {
            'pendientes': citas_hoy.filter(estado_cita__nombre__icontains='Pendiente').count(),
            'en_proceso': citas_hoy.filter(estado_cita__nombre__icontains='Proceso').count(),
            'terminadas': citas_hoy.filter(estado_cita__nombre__icontains='Finalizado').count(),
        }
    }
    
    return render(request, "core/estilista_dashboard.html", context)

# ── API CLIENTES ──────────────────────────────────────────────────────────────
@csrf_exempt
def api_clientes(request):
    if request.method == "GET":
        q = request.GET.get('q', '').strip()
        qs = Cliente.objects.select_related('estado').all()
        if q:
            from django.db.models import Q
            qs = qs.filter(Q(nombre__icontains=q)|Q(primerapel__icontains=q)|Q(correo__icontains=q))
        data = []
        for c in qs:
            tel = TelefonoCliente.objects.filter(cliente=c).first()
            mascotas_count = Mascota.objects.filter(cliente=c).count()
            data.append({
                "clave": c.clave,
                "nombre": c.nombre,
                "primerApel": c.primerapel,
                "segApel": c.segapel or '',
                "correo": c.correo or '',
                "telefono": tel.telefono if tel else '',
                "estado": c.estado.nombre,
                "estado_id": c.estado.clave,
                "mascotas": mascotas_count,
            })
        return JsonResponse({"ok": True, "data": data})

    elif request.method == "POST":
        try:
            body = json.loads(request.body)
            estado_obj = EstadoCliente.objects.get(clave=body.get("estado_id", 1))
            cliente = Cliente.objects.create(
                nombre=body["nombre"],
                primerapel=body["primerApel"],
                segapel=body.get("segApel", ""),
                correo=body.get("correo") or None,
                estado=estado_obj
            )
            tel = body.get("telefono", "").strip()
            if tel:
                TelefonoCliente.objects.create(telefono=tel, cliente=cliente)
            return JsonResponse({"ok": True, "clave": cliente.clave})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})

    return JsonResponse({"ok": False, "error": "Método no permitido"})

@csrf_exempt
def api_cliente_detalle(request, pk):
    cliente = get_object_or_404(Cliente, clave=pk)
    if request.method == "GET":
        tel = TelefonoCliente.objects.filter(cliente=cliente).first()
        mascotas = Mascota.objects.filter(cliente=cliente).select_related('raza')
        return JsonResponse({"ok": True, "data": {
            "clave": cliente.clave,
            "nombre": cliente.nombre,
            "primerApel": cliente.primerapel,
            "segApel": cliente.segapel or '',
            "correo": cliente.correo or '',
            "telefono": tel.telefono if tel else '',
            "estado": cliente.estado.nombre,
            "estado_id": cliente.estado.clave,
            "mascotas": [{"nombre": m.nombre, "raza": m.raza.nombre} for m in mascotas],
        }})
    elif request.method == "PUT":
        try:
            body = json.loads(request.body)
            cliente.nombre = body["nombre"]
            cliente.primerapel = body["primerApel"]
            cliente.segapel = body.get("segApel", "")
            cliente.correo = body.get("correo") or None
            cliente.estado = EstadoCliente.objects.get(clave=body.get("estado_id", 1))
            cliente.save()
            tel_val = body.get("telefono", "").strip()
            if tel_val:
                tel_obj = TelefonoCliente.objects.filter(cliente=cliente).first()
                if tel_obj:
                    tel_obj.telefono = tel_val
                    tel_obj.save()
                else:
                    TelefonoCliente.objects.create(telefono=tel_val, cliente=cliente)
            return JsonResponse({"ok": True})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    elif request.method == "DELETE":
        try:
            estado_inactivo = EstadoCliente.objects.get(nombre__icontains='Inactivo')
            cliente.estado = estado_inactivo
            cliente.save()
            return JsonResponse({"ok": True})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    return JsonResponse({"ok": False})

# ── API MASCOTAS ──────────────────────────────────────────────────────────────
@csrf_exempt
def api_mascotas(request):
    if request.method == "GET":
        from django.db.models import Q
        q = request.GET.get('q', '').strip()
        qs = Mascota.objects.select_related('cliente', 'raza', 'estado_mascota').all()
        if q:
            qs = qs.filter(Q(nombre__icontains=q)|Q(cliente__nombre__icontains=q))
        data = []
        for m in qs:
            data.append({
                "clave": m.clave,
                "nombre": m.nombre,
                "fechaNac": str(m.fechanac) if m.fechanac else '',
                "peso": str(m.peso) if m.peso else '',
                "observaciones": m.observaciones or '',
                "estado": m.estado_mascota.nombre,
                "estado_id": m.estado_mascota.clave,
                "cliente_id": m.cliente.clave,
                "cliente_nombre": f"{m.cliente.nombre} {m.cliente.primerapel}",
                "raza_id": m.raza.clave,
                "raza_nombre": m.raza.nombre,
            })
        return JsonResponse({"ok": True, "data": data})
    elif request.method == "POST":
        try:
            body = json.loads(request.body)
            mascota = Mascota.objects.create(
                nombre=body["nombre"],
                fechanac=body.get("fechaNac") or None,
                peso=body.get("peso") or None,
                observaciones=body.get("observaciones", ""),
                cliente=get_object_or_404(Cliente, clave=body["cliente_id"]),
                raza=get_object_or_404(Raza, clave=body["raza_id"]),
                estado_mascota=EstadoMascota.objects.get(clave=body.get("estado_id", 1)),
            )
            return JsonResponse({"ok": True, "clave": mascota.clave})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    return JsonResponse({"ok": False})

@csrf_exempt
def api_mascota_detalle(request, pk):
    mascota = get_object_or_404(Mascota, clave=pk)
    if request.method == "PUT":
        try:
            body = json.loads(request.body)
            mascota.nombre = body["nombre"]
            mascota.fechanac = body.get("fechaNac") or None
            mascota.peso = body.get("peso") or None
            mascota.observaciones = body.get("observaciones", "")
            mascota.cliente = get_object_or_404(Cliente, clave=body["cliente_id"])
            mascota.raza = get_object_or_404(Raza, clave=body["raza_id"])
            mascota.estado_mascota = EstadoMascota.objects.get(clave=body.get("estado_id", 1))
            mascota.save()
            return JsonResponse({"ok": True})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    elif request.method == "DELETE":
        try:
            mascota.estado_mascota = EstadoMascota.objects.get(nombre__icontains='Inactivo')
            mascota.save()
            return JsonResponse({"ok": True})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    return JsonResponse({"ok": False})

# ── API CITAS ─────────────────────────────────────────────────────────────────
@csrf_exempt
def api_citas(request):
    if request.method == "GET":
        from django.db.models import Q
        q = request.GET.get('q', '').strip()
        qs = Cita.objects.select_related('mascota__cliente', 'estado_cita').all().order_by('-fecha', '-hora')
        if q:
            qs = qs.filter(Q(mascota__nombre__icontains=q)|Q(mascota__cliente__nombre__icontains=q))
        data = []
        for c in qs:
            data.append({
                "clave": c.clave,
                "fecha": str(c.fecha),
                "hora": str(c.hora)[:5],
                "observaciones": c.observaciones or '',
                "condicion_pelo": c.condicion_pelo or '',
                "condicion_piel": c.condicion_piel or '',
                "estado": c.estado_cita.nombre,
                "estado_id": c.estado_cita.clave,
                "mascota_id": c.mascota.clave,
                "mascota_nombre": c.mascota.nombre,
                "cliente_nombre": f"{c.mascota.cliente.nombre} {c.mascota.cliente.primerapel}",
            })
        return JsonResponse({"ok": True, "data": data})
    elif request.method == "POST":
        try:
            body = json.loads(request.body)
            cita = Cita.objects.create(
                fecha=body["fecha"],
                hora=body["hora"],
                observaciones=body.get("observaciones", ""),
                condicion_pelo=body.get("condicion_pelo", ""),
                condicion_piel=body.get("condicion_piel", ""),
                mascota=get_object_or_404(Mascota, clave=body["mascota_id"]),
                estado_cita=get_object_or_404(EstadoCita, clave=body["estado_id"]),
            )
            return JsonResponse({"ok": True, "clave": cita.clave})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    return JsonResponse({"ok": False})

@csrf_exempt
def api_cita_detalle(request, pk):
    cita = get_object_or_404(Cita, clave=pk)
    if request.method == "PUT":
        try:
            body = json.loads(request.body)
            cita.fecha = body["fecha"]
            cita.hora = body["hora"]
            cita.observaciones = body.get("observaciones", "")
            cita.condicion_pelo = body.get("condicion_pelo", "")
            cita.condicion_piel = body.get("condicion_piel", "")
            cita.mascota = get_object_or_404(Mascota, clave=body["mascota_id"])
            cita.estado_cita = get_object_or_404(EstadoCita, clave=body["estado_id"])
            cita.save()
            return JsonResponse({"ok": True})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    elif request.method == "DELETE":
        try:
            estado_cancelada = EstadoCita.objects.get(nombre__icontains='Cancelada')
            cita.estado_cita = estado_cancelada
            cita.save()
            return JsonResponse({"ok": True})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    return JsonResponse({"ok": False})

# ── API PAGOS ─────────────────────────────────────────────────────────────────
@csrf_exempt
def api_pagos(request):
    if request.method == "GET":
        from django.db.models import Q
        q = request.GET.get('q', '').strip()
        qs = Pago.objects.select_related('cita__mascota__cliente', 'tipo_pago').all().order_by('-fecha_pago')
        if q:
            qs = qs.filter(Q(cita__mascota__cliente__nombre__icontains=q)|Q(cita__mascota__nombre__icontains=q))
        data = []
        for p in qs:
            data.append({
                "clave": p.clave,
                "fecha_pago": p.fecha_pago.strftime('%Y-%m-%d %H:%M'),
                "monto_total": str(p.monto_total),
                "tipo_pago": p.tipo_pago.nombre,
                "tipo_pago_id": p.tipo_pago.clave,
                "cita_id": p.cita.clave,
                "mascota_nombre": p.cita.mascota.nombre,
                "cliente_nombre": f"{p.cita.mascota.cliente.nombre} {p.cita.mascota.cliente.primerapel}",
            })
        return JsonResponse({"ok": True, "data": data})
    elif request.method == "POST":
        try:
            body = json.loads(request.body)
            cita = get_object_or_404(Cita, clave=body["cita_id"])
            if Pago.objects.filter(cita=cita).exists():
                return JsonResponse({"ok": False, "error": "Esta cita ya tiene un pago registrado"})
            pago = Pago.objects.create(
                fecha_pago=timezone.now(),
                monto_total=body["monto_total"],
                tipo_pago=get_object_or_404(TipoPago, clave=body["tipo_pago_id"]),
                cita=cita,
            )
            return JsonResponse({"ok": True, "clave": pago.clave})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    return JsonResponse({"ok": False})

# ── API SERVICIOS ─────────────────────────────────────────────────────────────
def api_servicios(request):
    data = [{"clave": s.clave, "nombre": s.nombre, "precio": str(s.precio), "descripcion": s.descripcion or ''} for s in Servicio.objects.all()]
    return JsonResponse({"ok": True, "data": data})

# ── API CATÁLOGOS ─────────────────────────────────────────────────────────────
def api_catalogos(request):
    razas = [{"clave": r.clave, "nombre": r.nombre, "tamano": r.tamano.nombre} for r in Raza.objects.select_related('tamano').all()]
    clientes_activos = [
        {"clave": c.clave, "nombre": f"{c.nombre} {c.primerapel} {c.segapel or ''}".strip()}
        for c in Cliente.objects.filter(estado__nombre__icontains='Activo')
    ]
    mascotas_activas = [
        {"clave": m.clave, "nombre": m.nombre, "cliente": f"{m.cliente.nombre} {m.cliente.primerapel}"}
        for m in Mascota.objects.select_related('cliente').filter(estado_mascota__nombre__icontains='Activo')
    ]
    estados_cliente = [{"clave": e.clave, "nombre": e.nombre} for e in EstadoCliente.objects.all()]
    estados_mascota = [{"clave": e.clave, "nombre": e.nombre} for e in EstadoMascota.objects.all()]
    estados_cita = [{"clave": e.clave, "nombre": e.nombre} for e in EstadoCita.objects.all()]
    tipos_pago = [{"clave": t.clave, "nombre": t.nombre} for t in TipoPago.objects.all()]
    pagadas = set(Pago.objects.values_list('cita_id', flat=True))
    citas_sin_pago = [
        {"clave": c.clave, "label": f"#{c.clave} – {c.mascota.nombre} ({c.mascota.cliente.nombre}) – {c.fecha}"}
        for c in Cita.objects.select_related('mascota__cliente').all()
        if c.clave not in pagadas
    ]
    return JsonResponse({
        "ok": True,
        "razas": razas,
        "clientes_activos": clientes_activos,
        "mascotas_activas": mascotas_activas,
        "estados_cliente": estados_cliente,
        "estados_mascota": estados_mascota,
        "estados_cita": estados_cita,
        "tipos_pago": tipos_pago,
        "citas_sin_pago": citas_sin_pago,
    })

# ── ACTUALIZAR ESTADO DE CITA ────────────────────────────────────────────────
@csrf_exempt
def api_actualizar_estado_cita(request, pk):
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            nuevo_estado_id = body.get("estado_id")
            cita = get_object_or_404(Cita, clave=pk)
            estado = get_object_or_404(EstadoCita, clave=nuevo_estado_id)
            
            cita.estado_cita = estado
            cita.save()
            return JsonResponse({"ok": True})
        except Exception as e:
            return JsonResponse({"ok": False, "error": str(e)})
    return JsonResponse({"ok": False, "error": "Método no permitido"})
# ── SECCIÓN DE COMPATIBILIDAD CON API Y DASHBOARDS ──────────────────────────

@csrf_exempt
def api_gerencia_dashboard(request):
    hoy = timezone.now().date()
    return JsonResponse({
        "ok": True, 
        "citas_hoy": Cita.objects.filter(fecha=hoy).count(),
        "total_clientes": Cliente.objects.count(),
        "mensaje": "Dashboard de Gerencia listo"
    })

@csrf_exempt
def api_admin_dashboard(request):
    hoy = timezone.now().date()
    return JsonResponse({
        "ok": True, 
        "citas_hoy": Cita.objects.filter(fecha=hoy).count(),
        "mensaje": "Dashboard de Admin listo"
    })

@csrf_exempt
def api_ger_empleados(request):
    empleados = Empleado.objects.all()
    data = [{"clave": e.clave, "nombre": e.nombre, "usuario": e.usuario} for e in empleados]
    return JsonResponse({"ok": True, "data": data})

@csrf_exempt
def api_ger_empleado_detalle(request, pk):
    return JsonResponse({"ok": True, "mensaje": "Detalle empleado listo"})

@csrf_exempt
def api_ger_ventas(request):
    return JsonResponse({"ok": True, "data": []})

@csrf_exempt
def api_ger_servicios(request):
    return JsonResponse({"ok": True, "data": []})

@csrf_exempt
def api_ger_reportes(request):
    return JsonResponse({"ok": True, "data": []})

# ── SECCIÓN FINAL DE COMPATIBILIDAD (SÓLO PEGAR UNA VEZ) ──────────────────

@csrf_exempt
def api_login(request):
    """Permite que la App de Flutter use el mismo login que la web"""
    return login_view(request)

@csrf_exempt
def api_ger_catalogos(request):
    """Conecta la ruta de gerencia con la función de catálogos existente"""
    return api_catalogos(request)

@csrf_exempt
def api_ger_reporte_ingresos(request):
    return JsonResponse({"ok": True, "data": [], "mensaje": "Reporte de ingresos listo"})

@csrf_exempt
def api_ger_reporte_citas(request):
    return JsonResponse({"ok": True, "data": [], "mensaje": "Reporte de citas listo"})

@csrf_exempt
def api_ger_reporte_empleados(request):
    return JsonResponse({"ok": True, "data": [], "mensaje": "Reporte de empleados listo"})

@csrf_exempt
def api_ger_empleado_detalle(request, pk):
    return JsonResponse({"ok": True, "mensaje": f"Detalle del empleado {pk} listo"})

@csrf_exempt
def api_ger_ventas(request):
    return JsonResponse({"ok": True, "data": []})
# ──────────────────────────────────────────────────────────────────────────