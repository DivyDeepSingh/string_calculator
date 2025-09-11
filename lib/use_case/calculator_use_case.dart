import 'package:dartz/dartz.dart';

class CalculatorUseCase {
  Either<String, int> add(String numbers) {
    try {
      if (numbers.isEmpty) return const Right(0);

      final n = int.tryParse(numbers.trim());
      if (n != null) return Right(n);

      String delimiter = ',';
      bool isMultiCharDelimiter = false;

      if (numbers.startsWith('//')) {
        int delimiterEndIndex = numbers.indexOf(r'\n');
        if (delimiterEndIndex == -1) {
          delimiterEndIndex = numbers.indexOf(r'\n');
        }

        if (delimiterEndIndex == -1) {
          return Left('Invalid input: missing newline after delimiter');
        }
        final delimiterPart = numbers.substring(2, delimiterEndIndex);
        numbers = numbers.substring(delimiterEndIndex + 1);

        if (delimiterPart.startsWith('[') && delimiterPart.endsWith(']')) {
          delimiter = delimiterPart.substring(1, delimiterPart.length - 1);
          isMultiCharDelimiter = true;
        } else {
          delimiter = delimiterPart;
        }
      }

      numbers = numbers
          .replaceAll(r'\n', delimiter)
          .replaceAll('\n', delimiter);

      final parts = isMultiCharDelimiter
          ? numbers.split(RegExp(RegExp.escape(delimiter)))
          : numbers.split(delimiter);

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
