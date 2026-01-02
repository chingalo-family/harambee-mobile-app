import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/modules/home/components/number_button.dart';

class NumberKeypad extends StatelessWidget {
  final Function(String) onDigitPressed;
  final bool enableZeroButtons;

  const NumberKeypad({
    super.key,
    required this.onDigitPressed,
    required this.enableZeroButtons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildKeypadRow(['1', '2', '3', '0'], enableLast: enableZeroButtons),
        const SizedBox(height: 8),
        _buildKeypadRow(['4', '5', '6', '00'], enableLast: enableZeroButtons),
        const SizedBox(height: 8),
        _buildKeypadRow(['7', '8', '9', '000'], enableLast: enableZeroButtons),
      ],
    );
  }

  Widget _buildKeypadRow(List<String> numbers, {bool enableLast = true}) {
    return Row(
      children: numbers.asMap().entries.map((entry) {
        final isLast = entry.key == numbers.length - 1;
        final number = entry.value;
        final isEnabled = !isLast || enableLast;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: entry.key > 0 ? 8 : 0),
            child: NumberButton(
              number: number,
              enabled: isEnabled,
              onTap: () => _handleButtonPress(number),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _handleButtonPress(String number) {
    if (number == '00') {
      onDigitPressed('0');
      onDigitPressed('0');
    } else if (number == '000') {
      onDigitPressed('0');
      onDigitPressed('0');
      onDigitPressed('0');
    } else {
      onDigitPressed(number);
    }
  }
}
