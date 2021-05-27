import 'package:app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails;

  FullScreenImage({Key key, this.imageUrl, this.tag}) : super(key: key);

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: GestureDetector(
        onDoubleTapDown: _handleDoubleTapDown,
        onDoubleTap: _handleDoubleTap,
        child: Center(
          child: Hero(
            tag: tag,
            child: InteractiveViewer(
              transformationController: _transformationController,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
