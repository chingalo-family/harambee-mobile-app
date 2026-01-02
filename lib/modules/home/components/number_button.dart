import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final String number;
  final VoidCallback onTap;
  final bool enabled;

  const NumberButton({
    super.key,
    required this.number,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? Colors.white : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: enabled ? Colors.grey.shade300 : Colors.grey.shade200,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: enabled ? Colors.black : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
