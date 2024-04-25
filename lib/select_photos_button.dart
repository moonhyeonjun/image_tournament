import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:math';

import 'package:image_tournament/preview_photos.dart';

class SelectPhotosButton extends StatefulWidget {
  const SelectPhotosButton({super.key});

  @override
  State<SelectPhotosButton> createState() => _SelectPhotosButtonState();
}

class _SelectPhotosButtonState extends State<SelectPhotosButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black12),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black12,
            ),
            onPressed: () async {
              List<String> selectedPhotos = await selectPhotos();

              setState(() {
                _loading = false;
              });

              if (selectedPhotos.isEmpty || !context.mounted) return;

              if (!isPowerOfTwo(selectedPhotos.length)) {
                selectedPhotos = adjustToNearestPowerOfTwo(selectedPhotos);
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PreviewPhotos(selectedPhotos: selectedPhotos),
                ),
              );
            },
            child: const Text('Select Photos',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
          );
  }

  Future<List<String>> selectPhotos() async {
    setState(() {
      _loading = true;
    });

    List<String> selectedPhotos = [];
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();

    for (XFile image in images) {
      selectedPhotos.add(image.path);
    }

    return selectedPhotos;
  }
}

bool isPowerOfTwo(int n) {
  return n != 0 && (n & (n - 1)) == 0;
}

List<String> adjustToNearestPowerOfTwo(List<String> selectedPhotos) {
  int length = selectedPhotos.length;
  int nearestPowerOfTwo = pow(2, (log(length) / log(2)).ceil()).toInt();
  int itemsToRemove = length - nearestPowerOfTwo;
  if (itemsToRemove < 0) {
    nearestPowerOfTwo = pow(2, (log(length) / log(2)).floor()).toInt();
    itemsToRemove = length - nearestPowerOfTwo;
  }
  return selectedPhotos.sublist(0, length - itemsToRemove);
}
