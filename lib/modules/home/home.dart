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

              // Split layout: All participants on left, Number input on right
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side: All participants under Msimamo
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        child: ListView(
                          children: [
                            // Msimamo section header
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Msimamo',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            // Top 3 performers with medals
                            if (leaderboardState.topPerformers.isNotEmpty)
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
                            const SizedBox(height: 8),
                            // All remaining participants (rank 4 onwards)
                            ...leaderboardState.participants
                                .where((p) => p.rank > 3)
                                .map((participant) => Column(
                                      children: [
                                        LeaderboardItem(participant: participant),
                                        Divider(
                                          height: 1,
                                          color: Colors.grey.shade200,
                                        ),
                                      ],
                                    )),
                          ],
                        ),
                      ),
                    ),

                    // Right side: Number input area
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey.shade50,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Number display
                            NumberDisplay(
                              value: leaderboardState.currentInput,
                            ),
                            const SizedBox(height: 16),

                            // Number keypad with 0, 00, 000
                            Column(
                              children: [
                                // Row 1: 1, 2, 3, 0
                                Row(
                                  children: [
                                    Expanded(
                                      child: _NumberButton(
                                        number: '1',
                                        onTap: () => leaderboardState.appendDigit('1'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _NumberButton(
                                        number: '2',
                                        onTap: () => leaderboardState.appendDigit('2'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _NumberButton(
                                        number: '3',
                                        onTap: () => leaderboardState.appendDigit('3'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _NumberButton(
                                        number: '0',
                                        enabled: leaderboardState.currentInput.isNotEmpty &&
                                            int.tryParse(leaderboardState.currentInput) != null &&
                                            int.parse(leaderboardState.currentInput) > 0,
                                        onTap: () => leaderboardState.appendDigit('0'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Row 2: 4, 5, 6, 00
                                Row(
                                  children: [
                                    Expanded(
                                      child: _NumberButton(
                                        number: '4',
                                        onTap: () => leaderboardState.appendDigit('4'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _NumberButton(
                                        number: '5',
                                        onTap: () => leaderboardState.appendDigit('5'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _NumberButton(
                                        number: '6',
                                        onTap: () => leaderboardState.appendDigit('6'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _NumberButton(
                                        number: '00',
                                        enabled: leaderboardState.currentInput.isNotEmpty &&
                                            int.tryParse(leaderboardState.currentInput) != null &&
                                            int.parse(leaderboardState.currentInput) > 0,
                                        onTap: () {
                                          leaderboardState.appendDigit('0');
                                          leaderboardState.appendDigit('0');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Row 3: 7, 8, 9, 000
                                Row(
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
                                        number: '000',
                                        enabled: leaderboardState.currentInput.isNotEmpty &&
                                            int.tryParse(leaderboardState.currentInput) != null &&
                                            int.parse(leaderboardState.currentInput) > 0,
                                        onTap: () {
                                          leaderboardState.appendDigit('0');
                                          leaderboardState.appendDigit('0');
                                          leaderboardState.appendDigit('0');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Action buttons
                            ActionButtons(
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
                          ],
                        ),
                      ),
                    ),
                  ],
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
  final bool enabled;

  const _NumberButton({
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
