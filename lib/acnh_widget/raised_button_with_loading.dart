import 'package:flutter/material.dart';
import '../generated/l10n.dart';

class RaisedButtonWithLoading extends StatefulWidget {
  final Widget Function(BuildContext context, bool isLoading) childBuilder;
  final Future<void> Function() onProcess;

  const RaisedButtonWithLoading(
      {@required this.childBuilder, @required this.onProcess, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RaisedButtonWithLoadingState();
}

class _RaisedButtonWithLoadingState extends State<RaisedButtonWithLoading> {
  bool _isLoading = false;

  _handlePressed() async {
    setState(() {
      _isLoading = true;
    });
    await widget.onProcess();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: widget.childBuilder(context, _isLoading),
      onPressed: _isLoading ? null : _handlePressed,
    );
  }
}

class LoadingMessage extends StatelessWidget {
  final String message;

  LoadingMessage({this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.white54,
          ),
          height: 18,
          width: 18,
        ),
        SizedBox(width: 8),
        Text(message ?? S.of(context).processing,
            style: TextStyle(color: Colors.white54)),
      ],
    );
  }
}
