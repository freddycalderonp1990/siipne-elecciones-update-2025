# siipnemovil2



Flutter 3.29.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision c236373904 (6 days ago) • 2025-03-13 16:17:06 -0400
Engine • revision 18b71d647a
Tools • Dart 3.7.2 • DevTools 2.42.3


# Proyecto Flutter

Bienvenido a este proyecto Flutter. Consulta el [Changelog](CHANGELOG.md) para ver los cambios recientes.



## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


//Bloquear acceso
cuando desde el siipne se le asigna una situacion en la tabla dgoPerAsigOpe
tipo Situación 'A'=Activo, 'F'=Franco, 'NU'=Novedad UDGA, 'OR'=Pertenece a Otro Recinto



/para cambiar la version de kottlin - cambiar a 1.9.10
buscar el archivo settings.gradle


*****  IMPORTANTE +++++++++++++++++++++++++
//agregar esto en el info list para evitar la alerta de cifrado al mandar a revison

	<key>ITSAppUsesNonExemptEncryption</key>
	<false/>



//Permisos utilizando permission_handler - Para IOS - agregar en el
/Users/policianacional/AndroidStudioProjects/siipne_key/ios/Podfile
//si no se agrega siempre le va a salir permiso denegado

//IMPORTANTE
se debe ejecutar para aplicar los cambios

flutter clean
flutter pub get
cd ios
pod install


//1 = Activo 0= Desactivar

post_install do |installer|
installer.pods_project.targets.each do |target|
flutter_additional_ios_build_settings(target)

    target.build_configurations.each do |config|
      # You can remove unused permissions here
      # for more infomation: https://github.com/BaseflowIT/flutter-permission-handler/blob/master/permission_handler/ios/Classes/PermissionHandlerEnums.h
      # e.g. when you don't need camera permission, just add 'PERMISSION_CAMERA=0'
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: [PermissionGroup.calendarWriteOnly, PermissionGroup.calendar (until iOS 16)]
        'PERMISSION_EVENTS=0',

        ## dart: [PermissionGroup.calendarFullAccess, PermissionGroup.calendar (from iOS 17)]
       'PERMISSION_EVENTS_FULL_ACCESS=0',

        ## dart: PermissionGroup.reminders
        'PERMISSION_REMINDERS=0',

        ## dart: PermissionGroup.contacts
        'PERMISSION_CONTACTS=0',

        ## dart: PermissionGroup.camera
        'PERMISSION_CAMERA=1',

        ## dart: PermissionGroup.microphone
        'PERMISSION_MICROPHONE=0',

        ## dart: PermissionGroup.speech
        'PERMISSION_SPEECH_RECOGNIZER=0',

        ## dart: PermissionGroup.photos
        'PERMISSION_PHOTOS=1',

        ## dart: [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]
        'PERMISSION_LOCATION=0',

        ## dart: PermissionGroup.notification
        'PERMISSION_NOTIFICATIONS=0',

        ## dart: PermissionGroup.mediaLibrary
        'PERMISSION_MEDIA_LIBRARY=0',

        ## dart: PermissionGroup.sensors
        'PERMISSION_SENSORS=0',

        ## dart: PermissionGroup.bluetooth
        'PERMISSION_BLUETOOTH=0',

        ## dart: PermissionGroup.appTrackingTransparency
        'PERMISSION_APP_TRACKING_TRANSPARENCY=0',

        ## dart: PermissionGroup.criticalAlerts
        'PERMISSION_CRITICAL_ALERTS=0',

        ## dart: PermissionGroup.assistant
        'PERMISSION_ASSISTANT=0',
      ]

    end
end
end


# Inyección de Dependencias en GetX

En **GetX**, hay diferentes formas de inyectar dependencias según el ciclo de vida y el momento en que se necesiten. A continuación se detallan las distintas formas de inyección disponibles:

## 1. `Get.put<T>(T dependency)`

### Descripción:
Crea e inyecta la instancia **de inmediato** y la mantiene viva mientras la aplicación esté en ejecución.

### Ejemplo:
```dart
Get.put<AuthController>(AuthController());
```





## 2. `Get.lazyPut<T>(() => T())`

### Descripción:
Crea la instancia **solo cuando se usa por primera vez**. Si se destruye, **no se recrea automáticamente**, a menos que se use `fenix: true`.

### Ejemplo:
```dart
Get.lazyPut<ProfileController>(() => ProfileController());
```

## 3. `Get.put<T>(T())`

### Descripción:
Crea y **pone una instancia de un controlador en memoria** de forma inmediata. Esta instancia estará disponible durante toda la vida útil de la aplicación, **hasta que se cierre la aplicación**.

### Ejemplo:
```dart
Get.put<ProfileController>(ProfileController());
```


## 4. `Get.putAsync<T>(() async => T())`

### Descripción:
Permite crear una instancia **asíncrona** de un controlador. Se usa cuando la creación del controlador requiere operaciones asíncronas, como consultas a bases de datos o APIs.

### Ejemplo:
```dart
Get.putAsync<ProfileController>(() async => ProfileController(await fetchUserProfile()));
```




