# 📌 Changelog

## [2.2.2] – CENSO POLICIAL 2026 (Lunes 27 de Abril de 2026)
- Implementacion de las notificaciones push 
# WEB
1. Se solicita la modificación de las aplicaciones existentes para la carga masiva de información correspondiente a Recintos, Mesas y Personas, 
con la finalidad de que los usuarios de las Secciones de Talento Humano Desconcentradas a Nivel Nacional puedan realizar esta actividad dentro 
del sistema SIIPNE3W respecto del personal que se encuentra en cada una de las unidades.
2. Se solicita la creación de una aplicación de reportes que permita visualizar el resultado del Censo Policial en cada uno de los Recintos 
y Mesas, considerando el ámbito de gestión correspondiente a cada uno de los usuarios de las Secciones de Talento Humano Desconcentradas a Nivel Nacional.
3. Dentro del proceso del Censo Policial se deberá incorporar el procedimiento correspondiente que permita registrar información adicional de los servidores policiales censados,
entre la cual se deberá considerar al menos los siguientes campos:
        a) Teléfono
        b) Correo electrónico
        c) Familiares o dependientes
        d) Autoidentificación
4. Establecer un mecanismo formal, controlado y trazable dentro del SIIPNE para gestionar solicitudes excepcionales de cambio de mesa de servidores policiales, con la finalidad 
de evitar afectaciones a la planificación original del proceso de Censo Policial.
5. Desarrollar e incorporar dentro del sistema de Censo Policial una funcionalidad que permita al censador modificar su ubicación geográfica únicamente en casos excepcionales 
debidamente justificados, para lo cual se deberá exigir el registro obligatorio de documentación de respaldo.
6. Proceso para cambio de la ubicacion de una mesa.
7. Implementar notificación para que se le notifique al usuario que ha sido sacado de un recinto.

# Móvil
1. Implementar notificación para que se le notifique al usuario que ha sido sacado de un recinto.

## [2.0.0] – Elecciones 2025 – Segunda Vuelta (13-abril-2025)
1. Se deberá implementar la validación de la ubicación de los recintos electorales con la validación de las coordenadas registradas por el dispositivo móvil del usuario al momento de encontrarse en el recinto electoral.
  - se agrega en la tabla dgoComisios el campo estadoRegistro ENUM('REGISTRADO', 'VALIDADO')
  - 
# Modificar
appmovil/siipneMovil/recintoElectoral/data/dataDgoProcElec.php
appmovil/siipneMovil/recintoElectoral/data/dataDgoReciElect.php
- refactorizacion de sentcias sql
- 

appmovil/siipneMovil/recintoElectoral/controller/controllerDgoReciElect.php
- se agrega el parametro onlyValidados


ENUM('REGISTRADO', 'VALIDADO')


### 🔒 Bloqueo de Acceso - implementado
- Implementación del bloqueo de acceso para anexarse o crear código.
- En la tabla `dgoPerAsigOpe`, se considera el campo `situacion` con los siguientes valores:
  - `F` → Franco
  - `NU` → Novedad UDGA
  - `OR` → Pertenece a Otro Recinto
- Condiciones para aplicar el bloqueo:
  - `idGenEstadop = 'N'`
  - `delLog = 'N'`
- El bloqueo aplica según el proceso correspondiente.

### 🚪 Abandonar Código - implementado
- Cuando un usuario abandona un código o el jefe lo expulsa desde la aplicación:
  - Se asigna la situación `AR` (Abandono Recinto).
  - En la observación se registra: **"ABANDONAR OPERATIVO (DESDE MÓVIL)"**.

### ➕ Crear Código y Agregar Personal - implementado
- Se agregó el campo `gradoPol` para ser insertado en la tabla `dgoPerAsigOpe`.
- Se habilitó la creación de nuevos registros de personal que no tienen grado en **SIIPNE 3W**, los cuales se almacenan en la tabla temporal `dgoNoUsuarios`.
- Validaciones mediante **cédula**, **estado** y **proceso**.
- Nota: Si un usuario está registrado en un proceso distinto, no será encontrado a menos que los procesos coincidan.

### 🚀 Finalizar Recinto - implementado
- Anteriormente solo validaba por la hora configurada del recinto.
- Ahora la validación determina si el usuario puede finalizar un recinto en función de la hora registrada.

### ✅ Validaciones Clave - implementado
- Si el usuario ya tiene un código activo e intenta generar uno nuevo, se redirige al código existente.
- No es posible tener **dos códigos activos en el mismo proceso** ni estar anexado a más de un código de forma simultánea.

### 🖼️ API Save File (26-marzo-2025) - implementado
- Creación de una API para almacenar imágenes.

### 🔑 Abandonar y Eliminar Código (27-marzo-2025) - implementado
- Nuevo diálogo para solicitar la clave de acceso cada vez que se selecciona **abandonar** o **eliminar** un código.
- Mensajes mejorados enfatizando que el abandono **no será considerado justificativo ante el CNE**.

### 🎨 Interfaz Renovada – 2.0.0+37 - implementado
- Diseño gráfico actualizado: más moderno, intuitivo y fácil de usar.
- Optimización de procesos para mayor rapidez y eficiencia.
- Mejoras de estabilidad y rendimiento.
- Incorporación de nuevas funcionalidades.

---

## [2.1.0] – Censo Policial

### 🔑 04-julio-2025 - implementado
- Cambio en autenticación:
  - Nuevo endpoint: `appmovil/apis/v2/auth/read.php` (retorna únicamente el token). (incluida en formulario)
  - Datos del usuario obtenidos desde: `appmovil/apis/v1/user/read.php`. (incluida en formulario)

### 🗂️ Proceso Censos - implementado
- Query inicial: `SELECT * FROM genEncPrueba`.
- Actualización de rutas:
  - `/Volumes/siipne/appmovil/clases/constantesModulos.php` → agregado el módulo correspondiente.
  - `qr/qrconfig.php` → agregado `PATH_CODIGO_QR_PNE_CENSO`. (incluida en formulario)
  - `/Volumes/siipne/clases/dobleFactor/claseAlgoritmoTOTP.php` → modificación de `getKeySecurity`. (incluida en formulario)
  - `appmovil/apis/v2/saveFile/read.php` → nueva versión de guardar archivos (retorna el nombre del archivo). (incluida en formulario)

### 📌 Cambio Importante (22-julio-2025) - implementado
- En `/Volumes/siipne/appmovil/apis/helper/responseApi.php`: (incluida en formulario)
  - Ahora se retorna **HTTP 204 (No Content)** cuando `data` está vacío o `null`.
- Pendiente de revisión: impacto en aplicaciones dependientes (posible error de interpretación).

### 📋 13-agosto-2025 – Menú de Aplicación - implementado
- `appmovil/apis/v1/menuApps/read.php` → validación para mostrar u ocultar botones en la interfaz.

### 🗺️ 18-agosto-2025 – Mesas de Censo - implementado
- Posibilidad de mostrar mesas en un mapa para validar su correcta configuración.
- Latitud y longitud pueden guardarse vacíos desde la web (validación posterior por el censista).
- Validación al escanear QR: si las coordenadas son incorrectas, se notifica al usuario.
- Implementación de API para actualizar coordenadas de mesas.

### 🔍 20-agosto-2025 – Validaciones en Elecciones - implementado
- Actualizaciones en validación de novedades para la app **SIIPNE Elecciones** en:
  - `siipne/appmovil/siipneElecciones/app_elecciones/controller/controllerNovedadesApi.php`
  - `siipne/appmovil/siipneElecciones/app_elecciones/controller/controllerAuthElecciones.php`
  - `siipne/appmovil/siipneElecciones/app_elecciones/clases/buscarOpcAppElecciones.phpp`
  - `siipne/appmovil/siipneElecciones/app_elecciones/clases/constante.php`
  - `siipne/appmovil/siipneElecciones/app_elecciones/controller/controllerRecintoPersonal.php`

### 🎨 21-agosto-2025 – Mejoras de Interfaz - implementado
- Cambios en el diseño de los **diálogos**.
- Actualización del diseño del **cargando**.
- Nueva funcionalidad para **mostrar u ocultar datos**.  


### 🎨 21-agosto-2025 – PDF - implementado
- Se implementa la funcionalidad de descargar los pdf del censo 
- se agrega la carpeta pdf en al app principal para vizualizar los pdfs descargados
- Se implemnta la funcionalidad en el paquete api provider para descargar pdf, medodo   
  Future<String> downloadPdf({
  required String segmento,
  required String url,
  Object? body,
  String namePdf="miPdf"

  }),


## [2.0.0] – ELECCIONES 2025 - CONSULTA (inicio del desarrollo 13-octubre-2025)

## REUINONES
- 
- LUNES 20 DE OCTUBRE DEL 2025 - SUBCOMANDO  PRESENTAR AVANCES DEL CATALOGO DE DELITOS SE AGREGA EL CATALGO DE FLAGRANCIA
- VIERNES 24 DE OCTUBRE DEL 2025 - PRESENTAR AVANCES 


### CAMBIOS
## ARCHIVOS
`siipne/appmovil/siipneMovil/recintoElectoral/data/dataDgoNovedadesEje.php`
## CARPETAS
appmovil/apis/v1/menuApps/


**Archivo:** `siipne/appmovil/siipneMovil/recintoElectoral/data/dataDgoNovedadesEje.php`  
**Fecha:** 21/10/2025  
**Autor:** Freddy Calderón

---

## 🔧 Modificaciones Realizadas

### 1. Función: `getNovedadesPadresSegunNovedadPadre`
- Se modificó el SQL para que los resultados se presenten **ordenados numéricamente** según la numeración inicial del campo `descripcion` (por ejemplo, del 1 al N).
- Se agregó la siguiente cláusula para garantizar un orden correcto por número y no alfabéticamente:
  ```sql
  ORDER BY CAST(SUBSTRING_INDEX(nov.descripcion, '.', 1) AS UNSIGNED)
  ```
- Se mantuvieron las condiciones de **`delLog`** e **`idGenEstado`** para asegurar coherencia con las demás funciones del módulo.

---

### 2. Función: `getNovedadesPadresSegunIdEje`
- Se incorporó la condición **`idGenEstado`** en el filtro principal del SQL, asegurando que solo se obtengan registros activos.
- Se añadió una subconsulta para determinar si cada novedad tiene **hijos registrados**, utilizando la siguiente estructura:
  ```sql
  CASE 
      WHEN (
          SELECT COUNT(*) 
          FROM dgoNovedadesElect h
          WHERE h.dgo_idDgoNovedadesElect = nov.idDgoNovedadesElect
            AND h.delLog = 'N'
      ) > 0 THEN 'SI'
      ELSE 'NO'
  END AS tieneHijos
  ```

---

### 3. Mejoras Generales
- Se optimizó la legibilidad del código SQL mediante una mejor organización y estandarización de alias de tablas.
- Se garantizó la coherencia en las validaciones de **estado (`idGenEstado`)** y **borrado lógico (`delLog`)** en ambas funciones.
- Se mejoró la trazabilidad de los datos, asegurando que solo se muestren registros válidos y correctamente ordenados.

---

**🟢 Resultado esperado:**  
Los listados de novedades se presentan **ordenados del 1 al N**, mostrando correctamente si poseen registros hijos, y filtrando únicamente aquellos con estado activo.



**API:** `apis/v1/menuApps/read.php`  
**Fecha:** 22/10/2025  
**Autor:** Freddy Calderón

---


### 🚀 Nueva Implementación: API `menuApps/read.php`
- Se implementa la API **`appmovil/apis/v1/menuApps/read.php`**, la cual permite **consultar si existen procesos activos de elecciones o censos**.
- En caso de existir un **proceso de elecciones activo**, el sistema **redirecciona automáticamente** al menú correspondiente de elecciones.
- Si **no existe un proceso de elecciones activo**, se muestra el **menú del censo policial** y el sistema **redirecciona automáticamente al módulo del censo policial**.

---

**🟢 Resultado esperado:**  
El sistema detecta dinámicamente el proceso activo y redirige al menú adecuado, garantizando una navegación automática, contextual y eficiente para el usuario.


### Canbios de consulta de procesos activos
- se cambio 
- /Volumes/siipne/appmovil/siipneMovil/recintoElectoral/controller/controllerDgoProcElec.php
- /Volumes/siipne/appmovil/siipneMovil/recintoElectoral/data/dataDgoCreaOpReci.php
-         $fecha = myFecha::getSoloFecha();

### 31-octubre del 2025
- Se implementa el diálogo con contador getWarningSiNoContador, con la finalidad de que el usuario lea la advertencia antes de continuar.
  Además, se solicita la clave al usuario y se le vuelve a preguntar si está seguro de continuar.
  Solo si confirma al final, el proceso continúa de manera normal.