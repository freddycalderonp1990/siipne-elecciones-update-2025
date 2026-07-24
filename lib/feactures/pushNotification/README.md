

## LIBRERIAS
#NOTIFICACIONES PUSH
firebase_core: ^4.7.0
firebase_messaging: ^16.2.0
flutter_local_notifications: ^19.4.1

## Guía Utilizar El feacture 
ruta. android/app/build.gradle.kts
Dentro de android {} agrega: isCoreLibraryDesugaringEnabled = true

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true

    }

y agregar 

dependencies {
coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}



Ejemplo:
```dart

runApp(MultiBlocProvider(providers: [
BlocProvider(create: (context) => GpsBloc()),
BlocProvider(create: (context) => LocationBloc()),
BlocProvider(create: (context) => CalculadoraBloc()),
], child: MyApp()));

```

se usa el widget GpsAccessScreen(), para mostrar el gps el mismo que esta implementado en el widget
WorkAreaPageWidget
