import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class AllConfettiWidget extends StatefulWidget {
  final Widget child;
  final bool play;

  const AllConfettiWidget({
    @required this.child,
    this.play,
    Key key,
  }) : super(key: key);
  @override
  _AllConfettiWidgetState createState() => _AllConfettiWidgetState();
}

class _AllConfettiWidgetState extends State<AllConfettiWidget> {
  ConfettiController controller;

  @override
  void initState() {
    super.initState();

    controller = ConfettiController(duration: Duration(seconds: 2));
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.state == ConfettiControllerState.playing) {
          controller.stop();
        } else {
          controller.play();
        }
      },
      child: Stack(
        children: [
          widget.child,
          buildConfetti(),
        ],
      ),
    );
  }

  Widget buildConfetti() => ConfettiWidget(
        confettiController: controller,
        colors: [
          Colors.red,
          Colors.blue,
          Colors.orange,
          Colors.purple,
          Colors.lightBlue,
          Colors.greenAccent,
        ],
        blastDirection: 0,
        // shouldLoop: true,
        // blastDirectionality: BlastDirectionality.explosive,
      );
}
