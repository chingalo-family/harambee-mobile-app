import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/modules/home/models/participant_model.dart';
import 'package:harambee_mobile_app/modules/home/components/leaderboard_item.dart';

class LeaderboardPanel extends StatelessWidget {
  final List<ParticipantModel> participants;

  const LeaderboardPanel({
    super.key,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          _buildHeader(context),
          _buildParticipantsList(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Msimamo',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  Widget _buildParticipantsList() {
    return Column(
      children: participants.map((participant) {
        final isLast = participant == participants.last;
        return Column(
          children: [
            LeaderboardItem(participant: participant),
            if (!isLast)
              Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
          ],
        );
      }).toList(),
    );
  }
}
