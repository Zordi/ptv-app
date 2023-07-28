import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class CustomIntroWidget extends StatefulWidget {
  final List<Slide> slides;
  final VoidCallback onDonePress;

  const CustomIntroWidget({
    required this.slides,
    required this.onDonePress,
  });

  @override
  _CustomIntroWidgetState createState() => _CustomIntroWidgetState();
}

class _CustomIntroWidgetState extends State<CustomIntroWidget> {
  PageController _controller = PageController();
  int _currentIndex = 0;

  void _onNextPress() {
    if (_currentIndex < widget.slides.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.slides.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            Slide slide = widget.slides[index];
            return Container(
              // Your slide content goes here
              child: Column(
                children: [
                  Text(slide.title!),
                  Text(slide.description!),
                  Image.network(slide.pathImage!),
                ],
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16.0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: _currentIndex < widget.slides.length - 1
                  ? _onNextPress
                  : widget.onDonePress,
              child: Text(
                _currentIndex < widget.slides.length - 1 ? 'Continue' : 'Done',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
