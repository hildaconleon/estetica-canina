from django.contrib import admin
from .models import *

# Configuración personalizada para Estilistas (Empleados)
@admin.register(Empleado)
class EstilistaAdmin(admin.ModelAdmin):
    # Esto pone columnas bonitas en la lista: Nombre, Apellido, Puesto y su Usuario
    list_display = ('nombre', 'primerapel', 'get_puesto', 'usuario')
    
    # Agrega un buscador por nombre y usuario
    search_fields = ('nombre', 'primerapel', 'usuario')
    
    # Agrega filtros a la derecha para ver empleados por puesto
    list_filter = ('puesto',)

    # Función para que en la lista se vea el nombre del puesto
    def get_puesto(self, obj):
        return obj.puesto.nombre
    get_puesto.short_description = 'Puesto / Cargo'

# Configuración para que las Citas muestren más información
@admin.register(Cita)
class CitaAdmin(admin.ModelAdmin):
    list_display = ('clave', 'fecha', 'hora', 'mascota', 'estado_cita')
    list_filter = ('fecha', 'estado_cita')
    date_hierarchy = 'fecha' # Agrega una barrita de tiempo para navegar por días/meses

# Registramos los demás tal como los tenías, pero añadimos los que faltan
admin.site.register(Cliente)
admin.site.register(Servicio)
admin.site.register(DetalleCita)
admin.site.register(Mascota)
admin.site.register(Puesto)
admin.site.register(Area)
admin.site.register(EstadoCita)
admin.site.register(EstadoCliente)
admin.site.register(Raza)
admin.site.register(Tamano)

