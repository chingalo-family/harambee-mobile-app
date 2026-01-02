import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/app_state/leaderboard_state/leaderboard_state.dart';
import 'package:harambee_mobile_app/modules/home/components/action_buttons.dart';
import 'package:harambee_mobile_app/modules/home/components/leaderboard_item.dart';
import 'package:harambee_mobile_app/modules/home/components/number_display.dart';
import 'package:harambee_mobile_app/modules/home/components/top_performer_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaderboardState>(context, listen: false).loadParticipants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Harambee',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Consumer<LeaderboardState>(
        builder: (context, leaderboardState, child) {
          if (leaderboardState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Header with total amount and Jumuhisho toggle
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                              'Tshs. ${leaderboardState.formattedTotalAmount}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
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
                              value: leaderboardState.jumuhisho,
                              onChanged: (_) => leaderboardState.toggleJumuhisho(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top performers section
                      if (leaderboardState.topPerformers.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Msimamo',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: leaderboardState.topPerformers
                                .map((participant) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: TopPerformerCard(
                                        participant: participant,
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Number display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: NumberDisplay(
                          value: leaderboardState.currentInput,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Simulated number grid (7, 8, 9, 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: _NumberButton(
                                number: '7',
                                onTap: () => leaderboardState.appendDigit('7'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _NumberButton(
                                number: '8',
                                onTap: () => leaderboardState.appendDigit('8'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _NumberButton(
                                number: '9',
                                onTap: () => leaderboardState.appendDigit('9'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _NumberButton(
                                number: '0',
                                onTap: () => leaderboardState.appendDigit('0'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Leaderboard list
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Text(
                                    'Orodha',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ...leaderboardState.participants.map(
                              (participant) => Column(
                                children: [
                                  LeaderboardItem(participant: participant),
                                  if (participant != leaderboardState.participants.last)
                                    Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Action buttons
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: ActionButtons(
                  onUndo: () => leaderboardState.deleteLastDigit(),
                  onClear: () => leaderboardState.clearInput(),
                  onAdd: () {
                    if (leaderboardState.currentInput.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Mchango umeongezwa!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      leaderboardState.addContribution();
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NumberButton extends StatelessWidget {
  final String number;
  final VoidCallback onTap;

  const _NumberButton({
    required this.number,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
