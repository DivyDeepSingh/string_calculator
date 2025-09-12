import 'package:dartz/dartz.dart';

class CalculatorUseCase {
  Either<String, int> add(String numbers) {
    try {
      if (numbers.isEmpty) return const Right(0);

      final n = int.tryParse(numbers.trim());
      if (n != null) return Right(n);

      // default delimiters
      final delimiters = [',', '\n'];

      // Handle custom delimiters
      if (numbers.startsWith('//')) {
        final newlineIndex = numbers.indexOf(r'\n');
        if (newlineIndex == -1) {
          return Left('Invalid input: missing newline after delimiter');
        }

        final delimiterPart = numbers.substring(2, newlineIndex);
        numbers = numbers.substring(newlineIndex + 1);

        if (delimiterPart.startsWith('[')) {
          // multiple delimiters inside []
          final matches = RegExp(r'\[(.*?)\]').allMatches(delimiterPart);
          for (var m in matches) {
            delimiters.add(m.group(1)!);
          }
        } else {
          // single delimiter
          delimiters.add(delimiterPart);
        }
      }

      // Replace all delimiters with a single comma
      for (var d in delimiters) {
        numbers = numbers.split(d).join(',');
      }

      // Split by comma
      final parts = numbers.split(',');

      int result = 0;
      final negatives = <int>[];
      for (var part in parts) {
        if (part.trim().isEmpty) continue;
        if (part.contains("n")) {
          part = part.replaceAll("n", "");
        }
        final numPart = int.tryParse(part.trim());
        if (numPart == null) continue;

        if (numPart < 0) {
          negatives.add(numPart);
        } else {
          result += numPart;
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
