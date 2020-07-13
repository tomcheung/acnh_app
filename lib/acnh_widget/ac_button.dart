import 'package:flutter/material.dart';

class AcButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color color;
  final Widget child;

  const AcButton({
    @required this.onPressed,
    this.color,
    this.child,
    Key key,
  }) : super(key: key);

  factory AcButton.text({
    @required VoidCallback onPressed,
    Color color,
    String text,
    Key key,
  }) {
    return AcButton(
      onPressed: onPressed,
      color: color,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      key: key,
    );
  }

  @override
  _AcButtonState createState() => _AcButtonState();
}

class _AcButtonState extends State<AcButton> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: 1,
      upperBound: 1.2,
    );
  }

  void _animateHighlightChange(bool isHighlight) {
    _animationController.animateTo(
      isHighlight ? 0.95 : 1,
      duration: const Duration(milliseconds: 150),
      curve: isHighlight ? Curves.easeInBack : Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaleTransition(
      scale: _animationController,
      child: MaterialButton(
        height: 45,
        color: widget.color ?? theme.buttonColor,
        splashColor: Colors.white.withAlpha(30),
        highlightColor: Colors.black12,
        elevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        onPressed: widget.onPressed,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white.withAlpha(200), width: 2),
          borderRadius: BorderRadius.all(
            Radius.elliptical(30, 18),
          ),
        ),
        onHighlightChanged: _animateHighlightChange,
        child: widget.child,
      ),
    );
  }
}
