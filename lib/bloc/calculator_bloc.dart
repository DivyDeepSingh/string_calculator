import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:string_calculator/use_case/calculator_use_case.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';
part 'calculator_bloc.freezed.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState.initial()) {
    on<InitialCalculatorEvent>((event, emit) {});

    on<OnCalculateStringEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      var res = await CalculatorUseCase().add(state.input);
      res.fold(
        (left) => emit(
          state.copyWith(isLoading: false, errorMessage: left, result: null),
        ),
        (right) => emit(
          state.copyWith(isLoading: false, result: right, errorMessage: null),
        ),
      );
    });

    on<OnUpdateInputEvent>((event, emit) {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(isLoading: false, input: event.input));
    });
  }
}
