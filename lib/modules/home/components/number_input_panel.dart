import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/modules/home/components/number_display.dart';
import 'package:harambee_mobile_app/modules/home/components/number_keypad.dart';
import 'package:harambee_mobile_app/modules/home/components/action_buttons.dart';

class NumberInputPanel extends StatelessWidget {
  final String currentInput;
  final Function(String) onDigitPressed;
  final VoidCallback onUndo;
  final VoidCallback onClear;
  final VoidCallback onAdd;
  final bool enableZeroButtons;

  const NumberInputPanel({
    super.key,
    required this.currentInput,
    required this.onDigitPressed,
    required this.onUndo,
    required this.onClear,
    required this.onAdd,
    required this.enableZeroButtons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          NumberDisplay(value: currentInput),
          const SizedBox(height: 16),
          NumberKeypad(
            onDigitPressed: onDigitPressed,
            enableZeroButtons: enableZeroButtons,
          ),
          const SizedBox(height: 16),
          ActionButtons(
            onUndo: onUndo,
            onClear: onClear,
            onAdd: onAdd,
          ),
        ],
      ),
    );
  }
}
