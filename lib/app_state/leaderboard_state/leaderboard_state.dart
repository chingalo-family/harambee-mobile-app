import 'package:flutter/material.dart';
import 'package:harambee_mobile_app/core/utils/format_utils.dart';
import 'package:harambee_mobile_app/modules/home/models/participant_model.dart';

class LeaderboardState extends ChangeNotifier {
  bool _loading = false;
  bool _jumuhisho = false;
  String _currentInput = '';
  List<ParticipantModel> _participants = [];

  bool get loading => _loading;
  bool get jumuhisho => _jumuhisho;
  String get currentInput => _currentInput;
  List<ParticipantModel> get participants => _participants;

  double get totalAmount {
    return _participants.fold(0.0, (sum, participant) => sum + participant.amount);
  }

  String get formattedTotalAmount {
    return FormatUtils.formatWithThousandsSeparator(totalAmount);
  }

  List<ParticipantModel> get topPerformers {
    if (_participants.length < 3) return _participants;
    return _participants.sublist(0, 3);
  }

  void toggleJumuhisho() {
    _jumuhisho = !_jumuhisho;
    notifyListeners();
  }

  void appendDigit(String digit) {
    if (_currentInput.length < 10) {
      _currentInput += digit;
      notifyListeners();
    }
  }

  void deleteLastDigit() {
    if (_currentInput.isNotEmpty) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      notifyListeners();
    }
  }

  void clearInput() {
    _currentInput = '';
    notifyListeners();
  }

  void addContribution() {
    if (_currentInput.isNotEmpty) {
      // Future implementation: Add contribution to backend
      // For now, just clear the input
      clearInput();
    }
  }

  Future<void> loadParticipants() async {
    _loading = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock data
      _participants = [
        ParticipantModel(id: '1', name: 'John Mwamba', amount: 150000, rank: 1),
        ParticipantModel(id: '2', name: 'Sarah Kimani', amount: 125000, rank: 2),
        ParticipantModel(id: '3', name: 'David Njoroge', amount: 100000, rank: 3),
        ParticipantModel(id: '4', name: 'Grace Muthoni', amount: 85000, rank: 4),
        ParticipantModel(id: '5', name: 'Peter Omondi', amount: 75000, rank: 5),
        ParticipantModel(id: '6', name: 'Mary Wanjiru', amount: 65000, rank: 6),
        ParticipantModel(id: '7', name: 'James Kamau', amount: 55000, rank: 7),
        ParticipantModel(id: '8', name: 'Ruth Achieng', amount: 45000, rank: 8),
        ParticipantModel(id: '9', name: 'Daniel Kiprop', amount: 35000, rank: 9),
        ParticipantModel(id: '10', name: 'Elizabeth Nyambura', amount: 25000, rank: 10),
      ];
    } catch (e) {
      // Handle error
    }

    _loading = false;
    notifyListeners();
  }
}
