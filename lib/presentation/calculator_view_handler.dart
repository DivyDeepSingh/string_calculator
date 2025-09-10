import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_calculator/bloc/calculator_bloc.dart';
import 'package:string_calculator/presentation/calculator_view.dart';

class CalculatorViewHandler extends StatelessWidget {
  const CalculatorViewHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalculatorBloc>(
      create: (context) => CalculatorBloc()..add(InitialCalculatorEvent()),
      child: BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
          return Stack(
            children: [
              CalculatorView(calculatorState: state),
              state.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
