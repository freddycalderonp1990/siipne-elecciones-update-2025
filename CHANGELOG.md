# Changelog

## [2.0.0] - Elecciones 2025 - Segunda Vuelta - 13-abrir-2025

### Bloqueo de Acceso
- Implementación del bloqueo de acceso para anexarse o crear código.
- En la tabla `dgoPerAsigOpe`, se considera el campo `situacion` con los siguientes valores:
  - `'F'` = Franco  
  - `'NU'` = Novedad UDGA  
  - `'OR'` = Pertenece a Otro Recinto  
- Para aplicar el bloqueo, los registros deben cumplir las siguientes condiciones:
  - `idGenEstadop = 'N'`
  - `delLog = 'N'`
  - El bloqueo es según el proceso.

### Abandonar Código
- Al momento de que el usuario abandone un código o el jefe lo expulse desde la aplicación, se realizan los siguientes cambios:
  - Se asigna la situación `AR` = Abandono Recinto.  
  - En la observación, se registra: **"ABANDONAR OPERATIVO (DESDE MÓVIL)"**.

## CREAR CODIGO Y AGREGAR PERSONAL
- Se agrego el idDgpGrado, para ser inseerrtado en la tabla dgoPerAsigOpe
- 

### Agregar Nuevo Personal 
- Se permite agregar personal nuevo que aún no está registrado y no tiene grado en el **SIIPNE 3W**.
- Estos registros se almacenan en la tabla temporal `dgoNoUsuarios`, donde se guardan junto con su grado y proceso.
- Se realiza la verificación según la **cédula**, **estado** y **proceso**.
- Importante: Si un usuario ya está registrado en un proceso diferente (por ejemplo, `9`), pero se crea el proceso `10`, no se encontrará a menos que coincidan los procesos.
- al final no se considero pero la funcionalidad se encuentra implementada

### 🚀 Finalizar Recinto
- Antes, solo validaba si era un recinto con la hora configurada para permitir su finalización.
- Ahora, la validación se basa en la hora configurada para determinar si el usuario puede finalizar un recinto.

### ✅ Validaciones Comprobadas
- Si el usuario crea o ya tiene un código activo e intenta generar uno nuevo, se verifica la existencia del código y se le redirige al código activo correspondiente.
- Si el usuario intenta anexarse a un código y ya está anexado o ha creado uno previamente, se le redirige al código que le corresponde.
- El usuario **no puede tener dos códigos activos** en el mismo proceso ni estar anexado a dos códigos simultáneamente.
### 🚀 API Save FILE - 26-MARZO-2025
- Creacion de un api para guardar la imagenes
### ABANDONAR Y ELIMINAR CÓDIGO - 27-MARZO-2025
- Se agrega un dialogo para solicitar al usuario su clave de acceso al sistema cada vez que selecciona abandonar o eliminar un código
- Se mejoró los mensaje haciendo enfasis de que si abandona no será considerado como justificativo ante el CNE

### 2.0.0+37 
- Interfaz Gráfica Renovada: Diseño más moderno, intuitivo y fácil de usar.
- Automatización Mejorada: Procesos optimizados para mayor rapidez y eficiencia.
- Mayor Estabilidad y Rendimiento: Correcciones de errores y mejoras en la velocidad.
- Nuevas Funcionalidades: Incorporamos mejoras para hacer tu experiencia aún mejor.

### INICIO DEL DESARROLLO PARA CENSO POLICIAL 

### 04-julio-2025
- se cambia el auth del aplicativo al uri appmovil/apis/v2/auth/read.php el mismo que solo retorna el token
- se obtiene los datos del usuario desde la uri appmovil/apis/v1/user/read.php

### PROCESO CENSOS
- select * from genEncPrueba
- /Volumes/siipne/appmovil/clases/constantesModulos.php  - AGREGAR EL MODULO