part of 'calculadora_bloc.dart';

 class CalculadoraState extends Equatable {
  final double resultado;

  const CalculadoraState({required this.resultado});

  @override
  List<Object> get props => [resultado];

  CalculadoraState copyWith({required double? resultado})=>CalculadoraState(resultado: resultado??this.resultado);


}


