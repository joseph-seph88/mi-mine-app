import 'package:flutter/material.dart';
import 'package:mimine/common/styles/app_text_styles.dart';

class TextHighlightWidget {
  static Widget highlight(String searchText, String resultText) {
    if (searchText.isEmpty || resultText.isEmpty) {
      return RichText(
        text: TextSpan(
          text: resultText,
          style: AppTextStyles.highlightTextF16W600,
        ),
      );
    }

    final spans = <TextSpan>[];
    int start = 0;
    int index = resultText.indexOf(searchText, start);

    while (index != -1) {
      if (index > start) {
        spans.add(
          TextSpan(
            text: resultText.substring(start, index),
            style: AppTextStyles.highlightTextF16W600,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: resultText.substring(index, index + searchText.length),
          style: AppTextStyles.highlightTextF16W600Green,
        ),
      );

      start = index + searchText.length;
      index = resultText.indexOf(searchText, start);
    }

    if (start < resultText.length) {
      spans.add(
        TextSpan(
          text: resultText.substring(start),
          style: AppTextStyles.highlightTextF16W600,
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
