import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material show Card;

class Card extends StatelessWidget {
  final Color color;
  final List<Widget> content;
  final Widget leftImage;
  final EdgeInsetsGeometry margin;

  const Card({
    this.leftImage,
    this.content,
    this.color,
    this.margin = const EdgeInsets.all(4)
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return material.Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: margin,
      color: color ?? theme.colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              leftImage,
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: content),
              ),
            ]),
      ),
    );
  }
}
