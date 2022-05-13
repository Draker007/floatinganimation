import 'package:flutter/material.dart';

class Animatedheart extends StatefulWidget {
  const Animatedheart({Key? key}) : super(key: key);

  @override
  _AnimatedheartState createState() => _AnimatedheartState();
}

class _AnimatedheartState extends State<Animatedheart> with SingleTickerProviderStateMixin {
  double _opacity=1;
  late AnimationController _controller;
  late Animation<double> _animationFloatUp;
  late Animation<double> _animationGrowSize;
  late Animation<double> _animationopacity;

  late double _heartHeight;
  late double _heartWidth;
  late double _heartBottomLocation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Duration(seconds: 4), vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _heartHeight = MediaQuery.of(context).size.height / 2;
    _heartWidth = MediaQuery.of(context).size.height / 3;
    _heartBottomLocation = MediaQuery.of(context).size.height - _heartHeight;

    _animationFloatUp = Tween(begin: _heartBottomLocation, end: 0.0).animate(
      CurvedAnimation(

        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    
    _animationGrowSize = Tween(begin: 50.0, end: 50.0,).animate(

      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.75, curve: Curves.elasticInOut),
      ),
    );

    if (_controller.isCompleted) {

      _controller.reverse();
    } else {

      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _animationFloatUp,
      builder: (context, child) {
        return Container(
          child: child,
          margin: EdgeInsets.only(
            top: _animationFloatUp.value,
            right: _animationGrowSize.value  ,
          ),
          width: _animationGrowSize.value,
        );
      },
      child: GestureDetector(
        child: AnimatedOpacity(
          duration: const Duration(seconds:1),
          opacity: _opacity,
          child: Image.asset('assets/images/hart.jpg' ,
            height: _heartHeight,
            width: _heartWidth,
          ),
        ),
        onTap: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
      ),
    );
  }
}

