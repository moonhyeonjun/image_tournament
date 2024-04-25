import 'package:flutter/material.dart';

import 'dart:math';

class AnimatedCard extends StatefulWidget {
  final String imagePath;
  final String description;

  const AnimatedCard(
      {super.key, required this.imagePath, required this.description});

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  double _angle = 0;
  // bool _isBack = true;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => setState(() {
          _angle = (_angle + pi) % (2 * pi);
        }),
        child: SizeTransition(
          sizeFactor: _animation,
          axis: Axis.horizontal,
          axisAlignment: -1.0,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _angle),
            duration: const Duration(milliseconds: 1000),
            builder: (BuildContext con, double val, _) {
              // _isBack = (val >= (pi / 2)) ? false : true;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(val),
                child: Center(
                  child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget.imagePath,
                          fit: BoxFit.cover,
                        ),
                      )

                      // Todo: 사진에 대한 설명 카드 뒷면에 추가
                      // child: _isBack
                      //     ? ClipRRect(
                      //         borderRadius: BorderRadius.circular(20),
                      //         child: Image.asset(
                      //           widget.imagePath,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       )
                      //     : Center(
                      //         child: Text(
                      //           widget.description,
                      //           textAlign: TextAlign.center,
                      //           style: const TextStyle(
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //       ),
                      ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
