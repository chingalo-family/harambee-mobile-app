import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/modules/home/models/participant_model.dart';

class MedalBadge extends StatelessWidget {
  final MedalType medalType;
  final double size;

  const MedalBadge({
    super.key,
    required this.medalType,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    if (medalType == MedalType.none) {
      return const SizedBox.shrink();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ParticipantModel.getMedalColor(medalType),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.emoji_events,
          color: Colors.white,
          size: size * 0.6,
        ),
      ),
    );
  }
}
