library expandable_fab_lite;

import 'dart:math';

import 'package:flutter/material.dart';

/// Inspired From:
/// https://www.youtube.com/watch?v=pgstWBa35tk
/// https://docs.flutter.dev/cookbook/effects/expandable-fab

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.icon,
    this.color,
    this.fabSize,
    this.actionButtonSize,
    this.fabElevation,
    this.actionButtonElevation,
    this.fabMargin,
    this.controller,
    required this.children,
  }) : super(key: key);

  final List<ActionButton> children;
  final Widget? icon;
  final Color? color;
  final double? fabSize;
  final double? actionButtonSize;
  final double? fabElevation;
  final double? actionButtonElevation;
  final double? fabMargin;
  final ExpandableFabController? controller;

  @override
  State<ExpandableFab> createState() => ExpandableFabState();
}

class ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {

  bool _isMenuClosed = true;
  late final AnimationController _animationController;
  late final Animation _animation;
  List<Alignment> _alignments = [
    const Alignment(0.0, 1.0),
    const Alignment(0.0, 1.0),
    const Alignment(0.0, 1.0)
  ];
  double _fabSize = 56.0;
  double _actionButtonSize = 48.0;
  double _fabElevation = 4.0;
  double _actionButtonElevation = 4.0;
  double _fabMargin = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller?.setParent(this);
    _fabSize = widget.fabSize??_fabSize;
    _actionButtonSize = widget.actionButtonSize??_actionButtonSize;
    _fabElevation = widget.fabElevation??_fabElevation;
    _actionButtonElevation = widget.actionButtonElevation??_actionButtonElevation;
    _fabMargin = widget.fabMargin??_fabMargin;
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 275));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn);
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(_fabMargin),
      height: 250.0,
      width: 250.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ..._buildExpandingActionButtons(),
          _buildExpandableFab(),
        ],
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final buttons = <Widget>[];
    for (int i = 0; i < widget.children.length; i++) {
      buttons.add(AnimatedAlign(
        alignment: _alignments[i],
        duration: Duration(milliseconds: _isMenuClosed ? 275 : 875),
        curve: _isMenuClosed ? Curves.easeIn : Curves.elasticOut,
        child: AnimatedContainer(
          duration: Duration(milliseconds: _isMenuClosed ? 275 : 875),
          curve: _isMenuClosed ? Curves.easeIn : Curves.elasticOut,
          height: _actionButtonSize,
          width: _actionButtonSize,
          child: FloatingActionButton(
            backgroundColor: widget.children[i].color ?? Colors.black87,
            elevation: _isMenuClosed ? 0 : _actionButtonElevation,
            onPressed: (){
              widget.children[i].onPressed?.call();
              _toggleExpandableFab();
            },
            child: widget.children[i].icon,
          ),
        ),
      ));
    }
    return buttons;
  }

  Widget _buildExpandableFab() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.rotate(
        angle: _animation.value * pi * (3 / 4),
        child: AnimatedContainer(
          height: _isMenuClosed ? _fabSize : _fabSize-5,
          width: _isMenuClosed ? _fabSize : _fabSize-5,
          duration: const Duration(milliseconds: 375),
          curve: Curves.easeOut,
          child: FloatingActionButton(
            elevation: _fabElevation,
            backgroundColor: widget.color ?? Colors.blue,
            onPressed: _toggleExpandableFab,
            child: widget.icon ?? const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _toggleExpandableFab(){
    setState(() {
      if (_isMenuClosed) {
        _isMenuClosed = !_isMenuClosed;
        _animationController.forward();
        Future.delayed(const Duration(milliseconds: 10), () {
          _alignments[0] = const Alignment(-0.6, 0.6);
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          _alignments[1] = const Alignment(0.0, 0.2);
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          _alignments[2] = const Alignment(0.6, 0.6);
        });
      } else {
        _isMenuClosed = !_isMenuClosed;
        _animationController.reverse();
        _alignments = [
          const Alignment(0.0, 1.0),
          const Alignment(0.0, 1.0),
          const Alignment(0.0, 1.0)
        ];
      }
    });
  }
}

class ExpandableFabController {
  ExpandableFabState? expandableFabState;

  void setParent(ExpandableFabState expandableFabState) {
    this.expandableFabState = expandableFabState;
  }

  void closeFab() {
    if(expandableFabState?._isMenuClosed == false) {
      expandableFabState?._toggleExpandableFab();
    }
  }

  void openFab() {
    if(expandableFabState?._isMenuClosed != false) {
      expandableFabState?._toggleExpandableFab();
    }
  }
}

class ActionButton {
  const ActionButton({
    this.onPressed,
    required this.icon,
    this.color
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final Color? color;
}