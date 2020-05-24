import 'package:flutter/material.dart';

class PriceItem extends StatelessWidget {
  static const double _iconSize = 20;
  final String weekday;
  final int morningValue;
  final int afternoonValue;

  PriceItem({
    @required this.weekday,
    @required this.morningValue,
    @required this.afternoonValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(4),
      child: Column(
        children: [
          Text(weekday),
          Row(
            children: [
              Icon(
                Icons.brightness_7,
                size: _iconSize,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 30),
                child: Text(
                  morningValue.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          Row(
            children: [
              Icon(
                Icons.brightness_3,
                size: _iconSize,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 30),
                child: Text(
                  afternoonValue.toString(),
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
