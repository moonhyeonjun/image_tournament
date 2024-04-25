import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_tournament/animated_card.dart';
import 'package:image_tournament/card_selector.dart';

class GamePage extends StatefulWidget {
  final List<String> selectedPhotos;

  const GamePage({super.key, required this.selectedPhotos});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<String> selectedCards;
  late List<String> selectedCardsThisRound;
  late Random random;
  late int totalCardCount;
  late int round;

  @override
  void initState() {
    super.initState();
    selectedCards = List.from(widget.selectedPhotos);
    selectedCardsThisRound = [];
    random = Random();
    totalCardCount = selectedCards.length;
    round = 1;
  }

  void nextRound(String selectedCard, String unSelectedCard) {
    round++;
    selectedCardsThisRound.add(selectedCard);
    setState(() {
      selectedCards.remove(unSelectedCard);
      totalCardCount = selectedCards.length + selectedCardsThisRound.length;
    });

    if (selectedCards.length == selectedCardsThisRound.length) {
      setState(() {
        selectedCards = List.from(selectedCardsThisRound);
        selectedCardsThisRound.clear();
        totalCardCount = selectedCards.length + selectedCardsThisRound.length;
        round = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        selectedCards.length == 1
            ? 'Winner'
            : selectedCards.length <= 2
                ? 'Final'
                : selectedCards.length <= 4
                    ? 'Semi-Final ($round/${totalCardCount ~/ 2})'
                    : '$totalCardCount Round ($round/${totalCardCount ~/ 2})',
      )),
      body: Center(
        child: selectedCards.length == 1
            ? AnimatedCard(
                imagePath: selectedCards[0],
                description: 'Winner',
              )
            : _buildCardSelector(),
      ),
    );
  }

  Widget _buildCardSelector() {
    List<String> remainingCards = List.from(selectedCards);
    remainingCards.removeWhere((card) => selectedCardsThisRound.contains(card));

    if (remainingCards.length >= 2) {
      // Selecting card1
      String card1 = remainingCards[random.nextInt(remainingCards.length)];

      // Remove card1 from the list of available cards
      remainingCards.remove(card1);

      // Selecting card2 from the remaining cards
      String card2 = remainingCards[random.nextInt(remainingCards.length)];

      return CardSelector(
        card1: card1,
        card2: card2,
        onCardSelected: nextRound,
      );
    } else {
      // No cards left to display
      return const Text('No more cards left.');
    }
  }
}
