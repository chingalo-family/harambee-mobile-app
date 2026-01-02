import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/app_state/leaderboard_state/leaderboard_state.dart';
import 'package:harambee_mobile_app/core/utils/input_validation_helper.dart';
import 'package:harambee_mobile_app/modules/home/components/header_section.dart';
import 'package:harambee_mobile_app/modules/home/components/leaderboard_panel.dart';
import 'package:harambee_mobile_app/modules/home/components/number_input_panel.dart';
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
      appBar: _buildAppBar(context),
      body: Consumer<LeaderboardState>(
        builder: (context, leaderboardState, child) {
          if (leaderboardState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              _buildHeader(leaderboardState),
              _buildSplitLayout(context, leaderboardState),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Harambee',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildHeader(LeaderboardState state) {
    return HeaderSection(
      totalAmount: state.formattedTotalAmount,
      jumuhishoEnabled: state.jumuhisho,
      onJumuhishoToggle: state.toggleJumuhisho,
    );
  }

  Widget _buildSplitLayout(BuildContext context, LeaderboardState state) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeaderboardSection(state),
          _buildNumberInputSection(context, state),
        ],
      ),
    );
  }

  Widget _buildLeaderboardSection(LeaderboardState state) {
    return Expanded(
      flex: 1,
      child: LeaderboardPanel(
        participants: state.participants,
      ),
    );
  }

  Widget _buildNumberInputSection(BuildContext context, LeaderboardState state) {
    return Expanded(
      flex: 1,
      child: NumberInputPanel(
        currentInput: state.currentInput,
        onDigitPressed: state.appendDigit,
        onUndo: state.deleteLastDigit,
        onClear: state.clearInput,
        onAdd: () => _handleAddContribution(context, state),
        enableZeroButtons: InputValidationHelper.shouldEnableZeroButtons(
          state.currentInput,
        ),
      ),
    );
  }

  void _handleAddContribution(BuildContext context, LeaderboardState state) {
    if (state.currentInput.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mchango umeongezwa!'),
          duration: Duration(seconds: 2),
        ),
      );
      state.addContribution();
    }
  }
}
