# 🐾 Estética Canina – Sistema de Administración (Django)

## Requisitos
- Python 3.10+
- MariaDB / MySQL con la base de datos `estetica canina` importada
- `pip install django mysqlclient`

## Configuración rápida

1. **Importa la BD** en phpMyAdmin o desde terminal:
   ```
   mysql -u root -p < estetica_canina.sql
   ```

2. **Ajusta credenciales** en `estetica_canina/settings.py`:
   ```python
   'USER': 'root',
   'PASSWORD': 'tu_contraseña',
   ```

3. **Instala dependencias:**
   ```
   pip install django mysqlclient
   ```

4. **Ejecuta el servidor:**
   ```
   python manage.py runserver
   ```

5. **Accede en:** http://127.0.0.1:8000

   Usuario de prueba: `MariaT` / Contraseña: `MT090222`

## Módulos disponibles
| Módulo | Funciones |
|--------|-----------|
| **Clientes** | Ver, Crear, Editar, Dar de baja (inactivo) |
| **Mascotas** | Ver, Crear, Editar, Dar de baja – con selector de dueño (combo) |
| **Citas** | Ver, Crear, Editar, Eliminar |
| **Servicios** | Solo lectura (catálogo de servicios con precios) |
| **Pagos** | Registrar pagos vinculados a citas completadas |

## Estructura del proyecto
```
estetica_django/
├── core/
│   ├── models.py        ← Modelos ORM mapeados a tu BD
│   ├── views.py         ← Vistas + API JSON para todos los módulos
│   ├── urls.py          ← Rutas URL
│   └── templates/core/
│       ├── index.html   ← Login
│       └── administrativo.html ← SPA principal
└── estetica_canina/
    └── settings.py      ← Configuración (BD, timezone, etc.)
```

## APIs disponibles
- `GET/POST /api/clientes` — Lista y creación de clientes
- `GET/PUT/DELETE /api/clientes/<id>` — Detalle, edición y baja
- `GET/POST /api/mascotas` — Lista y creación de mascotas  
- `PUT/DELETE /api/mascotas/<id>` — Edición y baja
- `GET/POST /api/citas` — Lista y creación de citas
- `PUT/DELETE /api/citas/<id>` — Edición y eliminación
- `GET/POST /api/pagos` — Lista y registro de pagos
- `GET /api/servicios` — Catálogo de servicios
- `GET /api/catalogos` — Catálogos (razas, estados, tipos pago, etc.)
