import 'package:dartz/dartz.dart';

class CalculatorUseCase {
  Either<String, int> add(String numbers) {
    if (numbers.isEmpty) return const Right(0);

    final n = int.tryParse(numbers.trim());
    if (n != null) return Right(n);

    return const Left('Not a valid number'); // placeholder for later steps
  }
}
