import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onUndo;
  final VoidCallback onClear;
  final VoidCallback onAdd;

  const ActionButtons({
    super.key,
    required this.onUndo,
    required this.onClear,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: 'Ondoa',
            backgroundColor: Colors.grey.shade400,
            icon: Icons.backspace_outlined,
            onTap: onUndo,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            label: 'Futa',
            backgroundColor: const Color(0xFF8B0000),
            iconAsset: 'assets/icons/close_icon.svg',
            onTap: onClear,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            label: 'Ongeza',
            backgroundColor: const Color(0xFF1B5E5E),
            iconAsset: 'assets/icons/add.svg',
            onTap: onAdd,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final IconData? icon;
  final String? iconAsset;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.backgroundColor,
    this.icon,
    this.iconAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                )
              else if (iconAsset != null)
                SvgPicture.asset(
                  iconAsset!,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
