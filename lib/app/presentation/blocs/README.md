
## Guía de Archivos en Bloc

Este documento describe de forma sencilla la funcionalidad de cada archivo utilizado en el patrón Bloc para Flutter. 
Puedes usarlo como referencia rápida para entender cómo funcionan los componentes principales.

## Archivo: calculadora_event.dart

Propósito: Define las acciones o eventos que la aplicación puede realizar.

Clase base de eventos:

Contiene propiedades comunes a todos los eventos (por ejemplo, los valores num1 y num2 en una calculadora).

Facilita la comparación entre eventos usando Equatable.

Clases específicas de eventos:

Representan acciones concretas, como SumarEvent o RestarEvent.

Heredan de la clase base y pueden agregar propiedades adicionales si es necesario.

Ejemplo:
```dart
part of 'calculadora_bloc.dart';

sealed class CalculadoraEvent extends Equatable {

  final double num1;
  final double num2;
  const CalculadoraEvent({required this.num1,required this.num2});

  @override
  List<Object> get props => [num1, num2];
}

class SumarEvent extends CalculadoraEvent{
  const SumarEvent({required super.num1, required super.num2});

}


class RestarEvent extends CalculadoraEvent{
  const RestarEvent({required super.num1, required super.num2});

}
```

## Archivo: calculadora_state.dart

Propósito: Define el estado actual de la aplicación.

Clase de estado:

Representa la información que el Bloc comparte con la interfaz de usuario.

En una calculadora, puede incluir propiedades como el resultado actual.

Propiedad copyWith:

Permite crear un nuevo estado basado en el estado actual, actualizando solo las propiedades necesarias.

Ejemplo:
```dart
part of 'calculadora_bloc.dart';

class CalculadoraState extends Equatable {
  final double resultado;

  const CalculadoraState({required this.resultado});

  @override
  List<Object> get props => [resultado];

  CalculadoraState copyWith({required double? resultado})=>CalculadoraState(resultado: resultado??this.resultado);


}
```

# Archivo: calculadora_bloc.dart

Propósito: Contiene la lógica que conecta los eventos con los estados.

Clase CalculadoraBloc:

Extiende la clase Bloc y define la relación entre los eventos y los estados.

Escucha los eventos y ejecuta acciones como sumar o restar.

Uso del método on<Event>:

Asocia cada tipo de evento con una función que emite un nuevo estado.

en este caso se asigna el resultado para que valla sumando lo que tiene de valor la variable


Ejemplo:
```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calculadora_event.dart';
part 'calculadora_state.dart';

class CalculadoraBloc extends Bloc<CalculadoraEvent, CalculadoraState> {
  CalculadoraBloc() : super(CalculadoraState(resultado: 0)) {
    on<SumarEvent>((event, emit) {
      emit(CalculadoraState(resultado:state.resultado+ event.num1+event.num2));
    });

    on<RestarEvent>((event, emit) {
      emit(CalculadoraState(resultado: event.num1-event.num2));
    });
  }
}

```

Cómo funciona en conjunto

Ejecutar el evento


          final calculadoraBloc = BlocProvider.of<CalculadoraBloc>(Get.context!);

          calculadoraBloc.add(SumarEvent(num1: 1,num2: 2));

Acceder a la varible que estan definidas en el archvio CalculadoraBloc

      BlocBuilder<CalculadoraBloc, CalculadoraState>(
        builder: (context, state) {
          return Text(
            'Resultado: ${state.resultado}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        },
      ),