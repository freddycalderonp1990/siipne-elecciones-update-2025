# 📌 Changelog

## [2.0.0] – Elecciones 2025 – Segunda Vuelta (13-abril-2025)

### 🔒 Bloqueo de Acceso
- Implementación del bloqueo de acceso para anexarse o crear código.
- En la tabla `dgoPerAsigOpe`, se considera el campo `situacion` con los siguientes valores:
  - `F` → Franco
  - `NU` → Novedad UDGA
  - `OR` → Pertenece a Otro Recinto
- Condiciones para aplicar el bloqueo:
  - `idGenEstadop = 'N'`
  - `delLog = 'N'`
- El bloqueo aplica según el proceso correspondiente.

### 🚪 Abandonar Código
- Cuando un usuario abandona un código o el jefe lo expulsa desde la aplicación:
  - Se asigna la situación `AR` (Abandono Recinto).
  - En la observación se registra: **"ABANDONAR OPERATIVO (DESDE MÓVIL)"**.

### ➕ Crear Código y Agregar Personal
- Se agregó el campo `idDgpGrado` para ser insertado en la tabla `dgoPerAsigOpe`.
- Se habilitó la creación de nuevos registros de personal que no tienen grado en **SIIPNE 3W**, los cuales se almacenan en la tabla temporal `dgoNoUsuarios`.
- Validaciones mediante **cédula**, **estado** y **proceso**.
- Nota: Si un usuario está registrado en un proceso distinto, no será encontrado a menos que los procesos coincidan.

### 🚀 Finalizar Recinto
- Anteriormente solo validaba por la hora configurada del recinto.
- Ahora la validación determina si el usuario puede finalizar un recinto en función de la hora registrada.

### ✅ Validaciones Clave
- Si el usuario ya tiene un código activo e intenta generar uno nuevo, se redirige al código existente.
- No es posible tener **dos códigos activos en el mismo proceso** ni estar anexado a más de un código de forma simultánea.

### 🖼️ API Save File (26-marzo-2025)
- Creación de una API para almacenar imágenes.

### 🔑 Abandonar y Eliminar Código (27-marzo-2025)
- Nuevo diálogo para solicitar la clave de acceso cada vez que se selecciona **abandonar** o **eliminar** un código.
- Mensajes mejorados enfatizando que el abandono **no será considerado justificativo ante el CNE**.

### 🎨 Interfaz Renovada – 2.0.0+37
- Diseño gráfico actualizado: más moderno, intuitivo y fácil de usar.
- Optimización de procesos para mayor rapidez y eficiencia.
- Mejoras de estabilidad y rendimiento.
- Incorporación de nuevas funcionalidades.

---

## [2.1.0] – Censo Policial

### 🔑 04-julio-2025
- Cambio en autenticación:
  - Nuevo endpoint: `appmovil/apis/v2/auth/read.php` (retorna únicamente el token). (incluida en formulario)
  - Datos del usuario obtenidos desde: `appmovil/apis/v1/user/read.php`. (incluida en formulario)

### 🗂️ Proceso Censos
- Query inicial: `SELECT * FROM genEncPrueba`.
- Actualización de rutas:
  - `/Volumes/siipne/appmovil/clases/constantesModulos.php` → agregado el módulo correspondiente.
  - `qr/qrconfig.php` → agregado `PATH_CODIGO_QR_PNE_CENSO`. (incluida en formulario)
  - `/Volumes/siipne/clases/dobleFactor/claseAlgoritmoTOTP.php` → modificación de `getKeySecurity`. (incluida en formulario)
  - `appmovil/apis/v2/saveFile/read.php` → nueva versión de guardar archivos (retorna el nombre del archivo). (incluida en formulario)

### 📌 Cambio Importante (22-julio-2025)
- En `/Volumes/siipne/appmovil/apis/helper/responseApi.php`: (incluida en formulario)
  - Ahora se retorna **HTTP 204 (No Content)** cuando `data` está vacío o `null`.
- Pendiente de revisión: impacto en aplicaciones dependientes (posible error de interpretación).

### 📋 13-agosto-2025 – Menú de Aplicación
- `appmovil/apis/v1/menuApps/read.php` → validación para mostrar u ocultar botones en la interfaz.

### 🗺️ 18-agosto-2025 – Mesas de Censo
- Posibilidad de mostrar mesas en un mapa para validar su correcta configuración.
- Latitud y longitud pueden guardarse vacíos desde la web (validación posterior por el censista).
- Validación al escanear QR: si las coordenadas son incorrectas, se notifica al usuario.
- Implementación de API para actualizar coordenadas de mesas.

### 🔍 20-agosto-2025 – Validaciones en Elecciones
- Actualizaciones en validación de novedades para la app **SIIPNE Elecciones** en:
  - `siipne/appmovil/siipneElecciones/app_elecciones/controller/controllerNovedadesApi.php`
  - `siipne/appmovil/siipneElecciones/app_elecciones/controller/controllerAuthElecciones.php`
  - `siipne/appmovil/siipneElecciones/app_elecciones/clases/buscarOpcAppElecciones.phpp`
  - `siipne/appmovil/siipneElecciones/app_elecciones/clases/constante.php`
  - `siipne/appmovil/siipneElecciones/app_elecciones/controller/controllerRecintoPersonal.php`

### 🎨 21-agosto-2025 – Mejoras de Interfaz
- Cambios en el diseño de los **diálogos**.
- Actualización del diseño del **cargando**.
- Nueva funcionalidad para **mostrar u ocultar datos**.  


### 🎨 21-agosto-2025 – PDF 
- Se implementa la funcionalidad de descargar los pdf del censo 
- se agrega la carpeta pdf en al app principal para vizualizar los pdfs descargados
- Se implemnta la funcionalidad en el paquete api provider para descargar pdf, medodo   
  Future<String> downloadPdf({
  required String segmento,
  required String url,
  Object? body,
  String namePdf="miPdf"

  }),