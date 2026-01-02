import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/modules/home/models/participant_model.dart';

class LeaderboardItem extends StatelessWidget {
  final ParticipantModel participant;
  final VoidCallback? onTap;

  const LeaderboardItem({
    super.key,
    required this.participant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Show trophy with rank number for top 3, circular badge for others
            _buildRankIndicator(),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                participant.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              participant.displayAmount,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankIndicator() {
    // For top 3, show trophy with colored background and rank number
    if (participant.rank <= 3) {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: ParticipantModel.getMedalColor(participant.medalType),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              color: Colors.white.withOpacity(0.4),
              size: 24,
            ),
            Text(
              '${participant.rank}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    
    // For others, show simple circular rank badge
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '${participant.rank}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
