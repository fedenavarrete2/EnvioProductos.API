[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/2XVY4f2V)
# 📦 Sistema de Gestión de Envíos de Productos

## 📋 Enunciado del Ejercicio

Se necesita desarrollar una aplicación que permita gestionar envíos de productos a distintos puntos del país. Para ello Ud. dispone de un proyecto incompleto que deberá completar
### 🎯 Objetivos

#### 1. Definir una capa de acceso que permita:
- ✅ **Consultar envíos por dirección de cliente y estado**
- ✅ **Registrar la cancelación de un pedido**, actualizando su estado a: `Cancelado`

> **Nota:** Para desarrollarla puede deberá implementar un patrón Repository utilizando EF o ADO.NET como tecnología de soporte.

#### 2. Definir una WebApi que permita exponer los siguientes servicios:
- ✅ **GET /envios**: que permita consultar todos los envíos coincidentes con los filtros: dirección (búsqueda por patrón) y/o estado.
- ✅ **DELETE /envios/:id**: que permita registrar la cancelación de un envío a partir de su identificador.

#### 3. Crear una colección POSTMAN que permita validar la ejecución de los endpoints indicados en el punto anterior.

### ⚠️ Validaciones
- Cuando se registra la cancelación de un envío deberá validar que el estado sea diferente a `Cancelado`.

---

## 🏗️ Estructura del Proyecto

### 📁 Archivos Proporcionados

El proyecto incluye la siguiente estructura completa:

```
EnvioProductos.API/
├── 📂 Controllers/
│   ├── ✅ EnviosController.cs          # COMPLETAR: Métodos del controlador
│   ├── 🔒 ProductosController.cs       # (Para referencia)
│   └── 🔒 TransportistasController.cs  # (Para referencia)
├── 📂 Data/
│   └── ✅ EnvioProductosContext.cs     # DbContext completo
├── 📂 DTOs/
│   ├── ✅ EnvioDto.cs                  # DTO principal para el ejercicio
│   ├── 🔒 ProductoDto.cs              # (Para referencia)
│   ├── 🔒 DetalleEnvioDto.cs          # (Para referencia)
│   └── 🔒 TransportistaDto.cs         # (Para referencia)
├── 📂 Models/
│   ├── ✅ Envio.cs                     # Modelo principal
│   ├── ✅ DetalleEnvio.cs             # Detalle de envíos
│   ├── ✅ Transportista.cs            # Transportistas
│   ├── ✅ Producto.cs                 # Productos
│   └── ✅ TipoProducto.cs             # Tipos de productos
├── 📂 Repositories/
│   ├── ✅ IEnvioRepository.cs         # COMPLETAR: Interfaz del repositorio
│   ├── 🔒 IProductoRepository.cs      # (Para referencia)
│   └── 🔒 ITransportistaRepository.cs # (Para referencia)
├── 📂 Services/
│   ├── ✅ IEnvioService.cs            # COMPLETAR: Interfaz del servicio
│   ├── 🔒 IProductoService.cs         # (Para referencia)
│   └── 🔒 ITransportistaService.cs    # (Para referencia)
├── 📂 Scripts/
│   └── ✅ DatabaseScript.sql          # Script completo de BD
├── 📂 Postman/
│   └── ✅ Envio-Productos-Collection.json # Colección para testing
├── ✅ Program.cs                       # COMPLETAR: Configuración DI
├── ✅ appsettings.json                # Configuración completa
└── ✅ README.md                       # Este archivo
```

**Leyenda:**
- ✅ **Archivos que debe completar el estudiante**
- 🔒 **Archivos de referencia/contexto (no tocar)**

---

## 🚀 Configuración Inicial

### 1. 🗄️ Base de Datos
Ejecutar el script proporcionado para crear la base de datos:
```sql
-- Ejecutar: Scripts/DatabaseScript.sql
-- Esto creará la BD 'EnvioProductosDB' con datos de ejemplo
```

### 2. 🔧 Configuración del Proyecto
La configuración ya está lista en `appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=EnvioProductosDB;Trusted_Connection=true;"
  }
}
```

---

## ✏️ Tareas a Completar

### 🎯 **FOCO DEL EJERCICIO: Backend **

#### 1. 📊 **Backend - Completar `IEnvioRepository.cs`**
```csharp
public interface IEnvioRepository
{
    // TODO: Implementar método para consultar envíos con filtros
    List<Envio> GetEnviosConFiltros(string? direccion, string? estado);
    
    // TODO: Implementar método para obtener envío por ID
    Envio? GetEnvioById(int id);
    
    // TODO: Implementar método para actualizar estado
    bool ActualizarEstadoEnvio(int id, string nuevoEstado);
}
```

#### 2. 🏭 **Backend - Crear `EnvioRepository.cs`**
Implementar la interfaz usando **Entity Framework** o **ADO.NET**

#### 3. 🔧 **Backend - Completar `IEnvioService.cs`**
```csharp
public interface IEnvioService
{
    // TODO: Implementar lógica de negocio para filtros
    List<EnvioDto> GetEnviosConFiltros(string? direccion, string? estado);
    
    // TODO: Implementar lógica de cancelación con validaciones
    ResultadoOperacion CancelarEnvio(int id);
}
```

#### 4. 🏭 **Backend - Crear `EnvioService.cs`**
Implementar la lógica de negocio y validaciones

#### 5. 🌐 **Backend - Completar `EnviosController.cs`**
```csharp
[HttpGet]
public ActionResult<IEnumerable<EnvioDto>> GetEnvios([FromQuery] string? direccion = null, [FromQuery] string? estado = null)
{
    // TODO: Implementar usando _envioService.GetEnviosConFiltros()
}

[HttpDelete("{id}")]
public ActionResult CancelarEnvio(int id)
{
    // TODO: Implementar usando _envioService.CancelarEnvio()
    // Retornar NoContent() si es exitoso
    // Retornar BadRequest() si la validación falla
}
```

#### 6. ⚙️ **Backend - Configurar `Program.cs`**
```csharp
// TODO: Agregar configuración de Entity Framework
builder.Services.AddDbContext<EnvioProductosContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// TODO: Agregar inyección de dependencias
builder.Services.AddScoped<IEnvioRepository, EnvioRepository>();
builder.Services.AddScoped<IEnvioService, EnvioService>();

// TODO: Configurar CORS para permitir conexiones desde el frontend
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});
```

#### 7. 🎨 **Frontend - Desarrollar Interfaz de Usuario**
Crear una aplicación frontend (HTML/CSS/JavaScript, React, Angular, etc.) que :

**Funcionalidades requeridas:**
- ✅ **Consultar envíos** con filtros por dirección y estado
- ✅ **Mostrar lista de envíos** en formato tabla o tarjetas
- ✅ **Cancelar envíos** mediante botón de acción
- ✅ **Manejar respuestas** de la API (éxito/error)

**Elementos sugeridos:**
- Formulario de filtros (inputs para dirección y estado)
- Tabla/grid con los envíos obtenidos
- Botones de "Cancelar" para cada envío (excepto ya cancelados)
- Mensajes de confirmación/error
- Indicadores de carga

#### 8. 🔗 **Integración Frontend-Backend**
- Configurar llamadas HTTP a la API
- Manejar responses y errores
- Actualizar UI según respuestas del servidor

---

## 🔍 Endpoints Requeridos

### **GET /api/envios**
Consultar envíos con filtros opcionales

**Parámetros Query:**
- `direccion` (opcional): Búsqueda por patrón en la dirección
- `estado` (opcional): Filtro exacto por estado

**Ejemplos:**
```
GET /api/envios                                    # Todos los envíos
GET /api/envios?direccion=Corrientes               # Envíos con "Corrientes" en dirección  
GET /api/envios?estado=Pendiente                   # Envíos con estado "Pendiente"
GET /api/envios?direccion=San Martín&estado=EnTransito # Ambos filtros
```

**Respuesta exitosa (200):**
```json
[
  {
    "id": 1,
    "fechaEnvio": "2024-01-15T10:30:00",
    "direccionDestino": "Av. Corrientes 1234, CABA",
    "estado": "Entregado",
    "transportistaNombre": "TransExpress SA",
    "costoTotal": 950.48
  }
]
```

### **DELETE /api/envios/{id}**
Cancelar un envío (cambiar estado a "Cancelado")

**Validaciones:**
- ✅ El envío debe existir
- ✅ El estado debe ser diferente a "Cancelado"

**Respuestas:**
- `204 No Content`: Cancelación exitosa
- `400 Bad Request`: El envío ya está cancelado
- `404 Not Found`: Envío no encontrado

---

## 🧪 Testing con Postman

### 📥 Importar Colección
1. Abrir Postman
2. Importar el archivo: `Postman/Envio-Productos-Collection.json`
3. Configurar la variable `baseUrl` (ej: `https://localhost:7000`)

### 🔬 Casos de Prueba Incluidos
- ✅ **GET Todos los Envíos** - Sin filtros
- ✅ **GET Envíos por Dirección** - Filtro por patrón
- ✅ **GET Envíos por Estado** - Filtro exacto
- ✅ **GET Envíos con Ambos Filtros** - Combinación
- ✅ **DELETE Cancelar Envío (Exitoso)** - Caso positivo
- ✅ **DELETE Cancelar Envío (Ya Cancelado)** - Validación
- ✅ **DELETE Cancelar Envío (No Existe)** - Error 404

---

## 📊 Estados Válidos de Envío

| Estado | Descripción |
|--------|-------------|
| `Pendiente` | Envío registrado, esperando procesamiento |
| `EnTransito` | Envío en camino al destino |
| `Entregado` | Envío completado exitosamente |
| `Cancelado` | Envío cancelado |

---

## 🏁 Tabla de Puntajes

| Criterio | Puntaje |
|----------|---------|
| **Abstracción de datos** | 20 pts |
| **GET /envios** | 20 pts |
| **DELETE /envios/:id** | 20 pts |
| **Validaciones en DELETE** | 10 pts |
| **Desarrollo front-end** | 20 pts |
| **Integración con backend** | 10 pts |
| **TOTAL** | **100 pts** |

### 📝 **Desglose de Criterios:**

#### **Abstracción de datos (20 pts)**
- Implementación correcta del patrón Repository
- Uso apropiado de Entity Framework o ADO.NET
- Separación clara de responsabilidades

#### **GET /envios (30 pts)**
- Endpoint funcionando correctamente
- Filtros implementados (dirección y estado)
- Respuestas HTTP apropiadas

#### **DELETE /envios/:id (30 pts)**
- Endpoint de cancelación funcionando
- Actualización correcta del estado
- Manejo de errores

#### **Validaciones en DELETE (10 pts)**
- Validación de estado != "Cancelado"
- Validación de existencia del envío
- Mensajes de error apropiados


#### **Integración con backend (10 pts)**
- Comunicación exitosa con la API
- Manejo de respuestas HTTP
- Actualización de UI según respuestas

---

## 🚨 Notas Importantes

1. **Implementar tanto backend como frontend** según los puntajes asignados
2. **Usar el patrón Repository-Service-Controller** como se enseñó en clase
3. **Validar que el estado no sea "Cancelado"** antes de cancelar
4. **Probar con Postman** antes de entregar
5. **Asegurar integración frontend-backend funcional**
6. **Comprimir el proyecto completo** para la entrega en UVS

---

## 🎓 ¡Éxito en el Examen!

Recuerda: El ejercicio evalúa tu capacidad para implementar una solución full-stack completa. El 60% de la nota corresponde al backend (API) y el 40% al frontend e integración.

**¿Dudas?** Revisa los archivos de referencia proporcionados en el proyecto.

