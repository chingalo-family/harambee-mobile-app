import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String totalAmount;
  final bool jumuhishoEnabled;
  final VoidCallback onJumuhishoToggle;

  const HeaderSection({
    super.key,
    required this.totalAmount,
    required this.jumuhishoEnabled,
    required this.onJumuhishoToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTotalAmount(context),
          _buildJumuhishoToggle(context),
        ],
      ),
    );
  }

  Widget _buildTotalAmount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jumla',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Tshs. $totalAmount',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildJumuhishoToggle(BuildContext context) {
    return Row(
      children: [
        Text(
          'Jumuhisho',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 8),
        Switch(
          value: jumuhishoEnabled,
          onChanged: (_) => onJumuhishoToggle(),
        ),
      ],
    );
  }
}
