import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main_screen/main_screen.dart';

class MyButton extends StatefulWidget {
  MyButton(
      {required this.bloc,
        required this.onPressed,
        required this.child,
        required this.isIncrementer});

  final MainScreenBloc bloc;
  final VoidCallback onPressed;
  final Widget child;
  final bool isIncrementer;

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 1, end: 0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, state) {
        state = state as MainScreenLoaded;
        if (!widget.isIncrementer) {
          if (state.number == 0) {
            _animationController.forward();
          }

          if (state.number == 1 || state.number == 2) {
            _animationController.reverse();
          }
        } else {
          if (state.number == 10) {
            _animationController.forward();
          }

          if (state.number == 9 || state.number == 8) {
            _animationController.reverse();
          }
        }
      },
      child: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}

