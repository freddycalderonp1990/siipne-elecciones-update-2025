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
