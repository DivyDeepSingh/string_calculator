part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {}

class InitialCalculatorEvent extends CalculatorEvent {
  @override
  List<Object?> get props => [];
}

class OnCalculateStringEvent extends CalculatorEvent {
  @override
  List<Object?> get props => [];
}

class OnUpdateInputEvent extends CalculatorEvent {
  String input;
  OnUpdateInputEvent({required this.input});

  @override
  List<Object?> get props => [];
}
