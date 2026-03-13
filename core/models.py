from django.db import models

class Area(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=50)
    descripcion = models.CharField(max_length=255, blank=True, null=True)
    
    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'area'


class Cita(models.Model):
    clave = models.AutoField(primary_key=True)
    fecha = models.DateField()
    hora = models.TimeField()
    observaciones = models.TextField(blank=True, null=True)
    condicion_pelo = models.CharField(max_length=100, blank=True, null=True)
    condicion_piel = models.CharField(max_length=100, blank=True, null=True)
    estado_cita = models.ForeignKey('EstadoCita', models.DO_NOTHING, db_column='estado_cita')
    mascota = models.ForeignKey('Mascota', models.DO_NOTHING, db_column='mascota')
    empleado = models.ForeignKey('Empleado', models.DO_NOTHING, db_column='empleado', null=True, blank=True)
    
    def __str__(self):
        return f"Cita {self.clave}: {self.fecha} - {self.mascota.nombre}"

    class Meta:
        managed = True
        db_table = 'cita'


class Cliente(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    primerapel = models.CharField(db_column='primerApel', max_length=50)
    segapel = models.CharField(db_column='segApel', max_length=50, blank=True, null=True)
    correo = models.CharField(unique=True, max_length=100, blank=True, null=True)
    estado = models.ForeignKey('EstadoCliente', models.DO_NOTHING, db_column='estado')

    def __str__(self):
        return f"{self.nombre} {self.primerapel}"

    class Meta:
        managed = True
        db_table = 'cliente'


class DetalleCita(models.Model):
    servicio = models.OneToOneField('Servicio', models.DO_NOTHING, db_column='servicio', primary_key=True)
    cita = models.ForeignKey(Cita, models.DO_NOTHING, db_column='cita')
    precioaplicado = models.DecimalField(db_column='precioAplicado', max_digits=8, decimal_places=2)
    empleado = models.ForeignKey('Empleado', models.DO_NOTHING, db_column='empleado')

    def __str__(self):
        return f"Detalle {self.cita.clave} - {self.servicio.nombre}"

    class Meta:
        managed = True
        db_table = 'detalle_cita'
        unique_together = (('servicio', 'cita'),)


class Empleado(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    primerapel = models.CharField(db_column='primerApel', max_length=50)
    segapel = models.CharField(db_column='segApel', max_length=50, blank=True, null=True)
    fechacontra = models.DateField(db_column='fechaContra')
    usuario = models.CharField(unique=True, max_length=30)
    claveacceso = models.CharField(db_column='claveAcceso', max_length=255)
    puesto = models.ForeignKey('Puesto', models.DO_NOTHING, db_column='puesto')
    
    def __str__(self):
        return f"{self.nombre} {self.primerapel}"

    class Meta:
        managed = True
        db_table = 'empleado'
        verbose_name = "Estilista"
        verbose_name_plural = "Estilistas"


class EstadoCita(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=30)
    descripcion = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'estado_cita'


class EstadoCliente(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=30)
    descripcion = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'estado_cliente'

class EstadoMascota(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=30)
    descripcion = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'estado_mascota'


class Mascota(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    fechanac = models.DateField(db_column='fechaNac', blank=True, null=True)
    peso = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    observaciones = models.TextField(blank=True, null=True)
    estado_mascota = models.ForeignKey('EstadoMascota', models.DO_NOTHING, db_column='estado_mascota', default=1)
    cliente = models.ForeignKey(Cliente, models.DO_NOTHING, db_column='cliente')
    raza = models.ForeignKey('Raza', models.DO_NOTHING, db_column='raza')

    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'mascota'


class Pago(models.Model):
    clave = models.AutoField(primary_key=True)
    fecha_pago = models.DateTimeField(db_column='fecha_Pago')
    monto_total = models.DecimalField(db_column='Monto_total', max_digits=10, decimal_places=2)
    tipo_pago = models.ForeignKey('TipoPago', models.DO_NOTHING, db_column='tipo_pago')
    cita = models.OneToOneField(Cita, models.DO_NOTHING, db_column='cita')

    def __str__(self):
        return f"Pago {self.clave} - ${self.monto_total}"

    class Meta:
        managed = True
        db_table = 'pago'


class Puesto(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    descripcion = models.CharField(max_length=255, blank=True, null=True)
    area = models.ForeignKey(Area, models.DO_NOTHING, db_column='area')
    
    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'puesto'


class Raza(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    tamano = models.ForeignKey('Tamano', models.DO_NOTHING, db_column='tamaño')

    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'raza'


class Servicio(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    precio = models.DecimalField(max_digits=8, decimal_places=2)
    descripcion = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'servicio'


class Tamano(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=20)
    descripcion = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'tamaño'


class TelefonoCliente(models.Model):
    clave = models.AutoField(primary_key=True)
    telefono = models.CharField(db_column='Telefono', max_length=15)
    cliente = models.ForeignKey(Cliente, models.DO_NOTHING, db_column='cliente')

    def __str__(self):
        return f"Tel: {self.telefono} ({self.cliente.nombre})"

    class Meta:
        managed = True
        db_table = 'telefono_cliente'


class TelefonoEmpleado(models.Model):
    clave = models.AutoField(primary_key=True)
    telefono = models.CharField(db_column='Telefono', max_length=15)
    empleado = models.ForeignKey(Empleado, models.DO_NOTHING, db_column='empleado')

    def __str__(self):
        return f"Tel: {self.telefono} ({self.empleado.nombre})"

    class Meta:
        managed = True
        db_table = 'telefono_empleado'


class TipoPago(models.Model):
    clave = models.AutoField(primary_key=True)
    nombre = models.CharField(unique=True, max_length=30)
    descripcion = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return self.nombre

    class Meta:
        managed = True
        db_table = 'tipo_pago'