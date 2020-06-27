extension StringAsPercentage on double {
  String toPercentageString() => '${(this * 100).toStringAsFixed(1)}%';
}
