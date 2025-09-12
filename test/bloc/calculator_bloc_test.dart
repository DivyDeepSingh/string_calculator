import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:string_calculator/bloc/calculator_bloc.dart';

void main() {
  late CalculatorBloc bloc;

  setUp(() {
    bloc = CalculatorBloc();
    bloc.add(InitialCalculatorEvent());
  });

  test('initial state is CalculatorState.initial()', () {
    expect(bloc.state.input, '');
    expect(bloc.state.isLoading, false);
    expect(bloc.state.result, null);
    expect(bloc.state.errorMessage, null);
  });

  // Update input event
  blocTest<CalculatorBloc, CalculatorState>(
    'updates input correctly on OnUpdateInputEvent',
    build: () => bloc,
    act: (bloc) => bloc.add(OnUpdateInputEvent(input: '1,2,3')),
    expect: () => [
      CalculatorState.initial().copyWith(isLoading: true),
      CalculatorState.initial().copyWith(isLoading: false, input: '1,2,3'),
    ],
  );

  // Comma-separated numbers
  blocTest<CalculatorBloc, CalculatorState>(
    'calculates sum correctly for comma-separated numbers',
    build: () => bloc,
    seed: () => bloc.state.copyWith(input: '1,2,3'),
    act: (bloc) => bloc.add(OnCalculateStringEvent()),
    expect: () => [
      bloc.state.copyWith(
        isLoading: true,
        input: '1,2,3',
        result: null,
        errorMessage: null,
      ),
      bloc.state.copyWith(
        isLoading: false,
        input: '1,2,3',
        result: 6,
        errorMessage: null,
      ),
    ],
  );

  // Newline-separated numbers
  blocTest<CalculatorBloc, CalculatorState>(
    'calculates sum correctly for newline-separated numbers',
    build: () => bloc,
    seed: () => bloc.state.copyWith(input: '1\n2,3'),
    act: (bloc) => bloc.add(OnCalculateStringEvent()),
    expect: () => [
      bloc.state.copyWith(
        isLoading: true,
        input: '1\n2,3',
        result: null,
        errorMessage: null,
      ),
      bloc.state.copyWith(
        isLoading: false,
        input: '1\n2,3',
        result: 6,
        errorMessage: null,
      ),
    ],
  );

  // Custom delimiter
  blocTest<CalculatorBloc, CalculatorState>(
    'calculates sum correctly for custom delimiter',
    build: () => bloc,
    seed: () => bloc.state.copyWith(input: r'//;\n1;2'),
    act: (bloc) => bloc.add(OnCalculateStringEvent()),
    expect: () => [
      bloc.state.copyWith(
        isLoading: true,
        input: r'//;\n1;2',
        result: null,
        errorMessage: null,
      ),
      bloc.state.copyWith(
        isLoading: false,
        input: r'//;\n1;2',
        result: 3,
        errorMessage: null,
      ),
    ],
  );

  // Negative numbers
  blocTest<CalculatorBloc, CalculatorState>(
    'returns error for negative numbers',
    build: () => bloc,
    seed: () => bloc.state.copyWith(input: '1,-2,3'),
    act: (bloc) => bloc.add(OnCalculateStringEvent()),
    expect: () => [
      bloc.state.copyWith(
        isLoading: true,
        input: '1,-2,3',
        result: null,
        errorMessage: null,
      ),
      bloc.state.copyWith(
        isLoading: false,
        input: '1,-2,3',
        result: null,
        errorMessage: 'negative numbers not allowed -2',
      ),
    ],
  );

  // Empty input
  // Empty input
  blocTest<CalculatorBloc, CalculatorState>(
    'handles empty input correctly',
    build: () => bloc,
    seed: () => bloc.state.copyWith(input: ''),
    act: (bloc) => bloc.add(OnCalculateStringEvent()),
    expect: () => [
      bloc.state.copyWith(
        isLoading: true,
        input: '',
        result: null,
        errorMessage: null,
      ),
      bloc.state.copyWith(
        isLoading: false,
        input: '',
        result: 0,
        errorMessage: null,
      ),
    ],
  );
  // Multi-character delimiter
  blocTest<CalculatorBloc, CalculatorState>(
    'calculates sum correctly for multi-character delimiter',
    build: () => bloc,
    seed: () => bloc.state.copyWith(input: r'//[***]\n1***2***3'),
    act: (bloc) => bloc.add(OnCalculateStringEvent()),
    expect: () => [
      bloc.state.copyWith(
        isLoading: true,
        input: r'//[***]\n1***2***3',
        result: null,
        errorMessage: null,
      ),
      bloc.state.copyWith(
        isLoading: false,
        input: r'//[***]\n1***2***3',
        result: 6,
        errorMessage: null,
      ),
    ],
  );

  // Multiple delimiters
  blocTest<CalculatorBloc, CalculatorState>(
    'calculates sum correctly for multiple delimiters',
    build: () => bloc,
    seed: () => bloc.state.copyWith(input: r'//[*]\n1*2*3'),
    act: (bloc) => bloc.add(OnCalculateStringEvent()),
    expect: () => [
      bloc.state.copyWith(
        isLoading: true,
        input: r'//[*]\n1*2*3',
        result: null,
        errorMessage: null,
      ),
      bloc.state.copyWith(
        isLoading: false,
        input: r'//[*]\n1*2*3',
        result: 6,
        errorMessage: null,
      ),
    ],
  );
}
