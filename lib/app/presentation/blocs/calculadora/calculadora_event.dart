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
