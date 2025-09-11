import 'package:dartz/dartz.dart';

class CalculatorUseCase {
  Either<String, int> add(String numbers) {
    try {
      if (numbers.isEmpty) return const Right(0);

      final n = int.tryParse(numbers.trim());
      if (n != null) return Right(n);
      String delimiter = ',';
      if (numbers.startsWith('//')) {
        final delimiterEndIndex = numbers.indexOf(r'\n');
        delimiter = numbers.substring(2, delimiterEndIndex);
        numbers = numbers.substring(delimiterEndIndex + 1);
      }
      numbers = numbers.replaceAll(r'\n', delimiter);
      final parts = numbers.split(delimiter);
      int result = 0;
      final negatives = <int>[];
      for (var part in parts) {
        final num = int.tryParse(part.trim()) ?? 0;
        if (num < 0) {
          negatives.add(num);
        } else {
          result += num;
        }
      }
      if (negatives.isNotEmpty) {
        return Left('negative numbers not allowed ${negatives.join(", ")}');
      }
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
