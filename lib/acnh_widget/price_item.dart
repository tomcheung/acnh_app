import 'package:flutter/material.dart';

class PriceItem extends StatelessWidget {
  static const double _iconSize = 20;
  final String weekday;
  final String morningValue;
  final String afternoonValue;
  final MaterialColor color;

  const PriceItem({
    @required this.weekday,
    @required this.morningValue,
    @required this.afternoonValue,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? Colors.amber, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          Text(weekday),
          Row(
            children: [
              const Icon(
                Icons.brightness_7,
                size: _iconSize,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 30),
                child: Text(
                  morningValue,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          Row(
            children: [
              const Icon(
                Icons.brightness_3,
                size: _iconSize,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 30),
                child: Text(
                  afternoonValue,
                  textAlign: TextAlign.center,
                ),
              )
            ],
            mainAxisSize: MainAxisSize.min,
          )
        ],
      ),
    );
  }
}
