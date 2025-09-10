part of 'calculator_bloc.dart';

@freezed
class CalculatorState with _$CalculatorState {
  const factory CalculatorState({
    required String input,
    int? result,
    String? errorMessage,
    required bool isLoading,
  }) = _CalculatorState;

  factory CalculatorState.initial() =>
      const CalculatorState(input: '', isLoading: false);
}
