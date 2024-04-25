import 'package:flutter/material.dart';

class CardSelector extends StatelessWidget {
  final String card1;
  final String card2;
  final Function(String, String) onCardSelected;

  const CardSelector(
      {super.key,
      required this.card1,
      required this.card2,
      required this.onCardSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onCardSelected(card1, card2),
          child: Card(
            child: Image.asset(
              card1,
              width: 350,
              height: 350,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => onCardSelected(card2, card1),
          child: Card(
            child: Image.asset(
              card2,
              width: 350,
              height: 350,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
