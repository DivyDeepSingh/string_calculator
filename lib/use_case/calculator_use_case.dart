import 'package:dartz/dartz.dart';

class CalculatorUseCase {
  Either<String, int> add(String numbers) {
    if (numbers.isEmpty) return const Right(0);

    final n = int.tryParse(numbers.trim());
    if (n != null) return Right(n);

    // Step 2: handle comma-separated numbers
    final parts = numbers.split(',');
    int result = 0;

    for (var part in parts) {
      final num = int.tryParse(part.trim());
      if (num != null) {
        result += num;
      } else {
        return Left('Invalid number: $part');
      }
    }

    return Right(result);
  }
}
