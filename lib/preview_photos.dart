import 'package:flutter/material.dart';
import 'package:image_tournament/game_page.dart';

class PreviewPhotos extends StatelessWidget {
  final List<String> selectedPhotos;

  const PreviewPhotos({super.key, required this.selectedPhotos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Photos'),
      ),
      body: Stack(
        children: [
          Center(
            child: ListView.builder(
              itemCount: selectedPhotos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    selectedPhotos[index],
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black12),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GamePage(selectedPhotos: selectedPhotos),
                    ),
                  );
                },
                child: const Text(
                  'Start Game',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
