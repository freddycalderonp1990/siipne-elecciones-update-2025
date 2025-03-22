# Changelog

## [1.0.1] - Elecciones 2025 - Segunda Vuelta

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

### Agregar Nuevo Personal
- Se permite agregar personal nuevo que aún no está registrado y no tiene grado en el **SIIPNE 3W**.
- Estos registros se almacenan en la tabla temporal `dgoNoUsuarios`, donde se guardan junto con su grado y proceso.
- Se realiza la verificación según la **cédula**, **estado** y **proceso**.
- Importante: Si un usuario ya está registrado en un proceso diferente (por ejemplo, `9`), pero se crea el proceso `10`, no se encontrará a menos que coincidan los procesos.

