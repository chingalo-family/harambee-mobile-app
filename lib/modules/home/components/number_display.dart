import 'package:flutter/material.dart';

class NumberDisplay extends StatelessWidget {
  final String value;

  const NumberDisplay({
    super.key,
    required this.value,
  });

  String _formatWithThousandsSeparator(String value) {
    if (value.isEmpty) return '0';
    
    final buffer = StringBuffer();
    final reversed = value.split('').reversed.toList();
    
    for (int i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(reversed[i]);
    }
    
    return buffer.toString().split('').reversed.join('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'Tshs. ',
            style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
          Text(
            _formatWithThousandsSeparator(value),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
