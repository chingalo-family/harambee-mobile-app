import 'package:flutter/material.dart';

enum MedalType { gold, silver, bronze, none }

class ParticipantModel {
  final String id;
  final String name;
  final double amount;
  final int rank;

  ParticipantModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.rank,
  });

  MedalType get medalType {
    switch (rank) {
      case 1:
        return MedalType.gold;
      case 2:
        return MedalType.silver;
      case 3:
        return MedalType.bronze;
      default:
        return MedalType.none;
    }
  }

  String get formattedAmount {
    return _formatWithThousandsSeparator(amount);
  }

  String _formatWithThousandsSeparator(double value) {
    final intValue = value.toInt();
    final str = intValue.toString();
    final buffer = StringBuffer();
    
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    
    return buffer.toString();
  }

  String get displayAmount {
    return 'Tshs. $formattedAmount';
  }

  static Color getMedalColor(MedalType type) {
    switch (type) {
      case MedalType.gold:
        return const Color(0xFFFFD700);
      case MedalType.silver:
        return const Color(0xFFC0C0C0);
      case MedalType.bronze:
        return const Color(0xFFCD7F32);
      case MedalType.none:
        return Colors.transparent;
    }
  }
}
