import 'package:dartz/dartz.dart';

class CalculatorUseCase {
  Either<String, int> add(String numbers) {
    // Empty string check
    if (numbers.isEmpty) return const Right(0);

    // Single number
    final num = int.tryParse(numbers.trim());
    if (num != null) return Right(num);

    //  Two or more numbers separated by comma
    final parts = numbers.split(',');
    int result = 0;
    for (var part in parts) {
      final n = int.tryParse(part.trim());
      if (n != null) result += n;
    }
    return Right(result);
  }
}
