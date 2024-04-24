import 'package:flutter/material.dart';
import 'package:image_tournament/game_page.dart';

class StartGameButton extends StatelessWidget {
  const StartGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        List<String> selectedPhotos = selectPhotos();
        if (selectedPhotos.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GamePage(selectedPhotos: selectedPhotos),
            ),
          );
        }
      },
      child: const Text('Start Game',
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF000000),
          )),
    );
  }

  selectPhotos() {
    List<String> selectedPhotos = [
      'images/card1.jpg',
      'images/card2.jpg',
      'images/card3.jpg',
      'images/card4.jpg',
      'images/card5.jpg',
      'images/card6.jpg',
      'images/card7.jpg',
      'images/card8.jpg',
      'images/card9.jpg',
      'images/card10.jpg',
      'images/card11.jpg',
      'images/card12.jpg',
      'images/card13.jpg',
      'images/card14.jpg',
      'images/card15.jpg',
      'images/card16.jpg',
    ];

    return selectedPhotos;
  }
}
