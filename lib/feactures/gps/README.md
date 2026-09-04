

## LIBRERIAS
flutter_bloc: ^9.0.0 #Mapas
bloc: ^9.0.0
equatable: ^2.0.7
permission_handler: ^11.3.1 # Solicita Permisos del dispositivo al usuario (Ubicacion,Galeria.....)
geolocator: ^13.0.2 #ubicacion Gps, del dispositivo
flutter_map: ^7.0.2 #0.9.0 #mapas openstreetmap (TRAE latlong)

## Guía Utilizar El feacture GPS

en el main se debe agregar el MultiBlocProvider

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
