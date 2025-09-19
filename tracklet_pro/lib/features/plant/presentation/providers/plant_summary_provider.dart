import 'package:flutter/foundation.dart';

class PlantSummaryProvider with ChangeNotifier {
  String? _selectedCardId;
  String? get selectedCardId => _selectedCardId;

  // Set default selected card
  PlantSummaryProvider() {
    _selectedCardId = 'gas_available'; // Default to first card
  }

  void selectCard(String cardId) {
    // Toggle selection - if clicking the same card, deselect it
    _selectedCardId = _selectedCardId == cardId ? null : cardId;
    notifyListeners();
  }

  bool isCardSelected(String cardId) => _selectedCardId == cardId;
}
