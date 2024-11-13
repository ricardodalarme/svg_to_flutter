import 'package:recase/recase.dart';
import 'package:svg_to_flutter/src/utils/dart_keywords.dart';

String normalizeText(String text) {
  var normalizedText = text.snakeCase;

  if (dartKeywords.contains(normalizedText)) {
    normalizedText += '_';
  }

  if (normalizedText.isNotEmpty && normalizedText[0].contains(RegExp(r'\d'))) {
    return '\$$normalizedText';
  }

  return normalizedText;
}
