import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material show TextField;

class TextField extends StatefulWidget {
  final String placeholderText;
  final String value;
  final TextInputType type;
  final Duration debounceTime;
  final TextAlign textAlign;
  final BorderRadius borderRadius;
  final bool selectOnFocus;
  final void Function(String) onTextChange;

  const TextField({
    Key key,
    this.placeholderText,
    this.value,
    this.textAlign = TextAlign.center,
    this.onTextChange,
    this.type,
    this.borderRadius = const BorderRadius.all(Radius.circular(90.0)),
    this.debounceTime,
    this.selectOnFocus = false
  }) : super(key: key);

  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  final TextEditingController editController = TextEditingController();
  final _focusNode = FocusNode();
  VoidCallback _lastCallback;
  Timer _debounceTimer;

  @override
  void initState() {
    super.initState();
    editController.text = widget.value;
    editController.addListener(notifyTextChange);

    _focusNode.addListener(() {
      if (widget.selectOnFocus && _focusNode.hasFocus) {
        editController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: editController.text.length,
        );
      }
    });
  }

  @override
  void didUpdateWidget(TextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (editController.text != widget.value) {
      editController.text = widget.value;
    }
  }

  void notifyTextChange() {
    if (widget.onTextChange == null) {
      return;
    }
    if (widget.debounceTime != null) {
      if (_debounceTimer?.isActive ?? false) {
        _debounceTimer.cancel();
      }

      _debounceTimer = Timer(widget.debounceTime, () {
        widget.onTextChange(editController.text);
      });
    } else {
      widget.onTextChange(editController.text);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (_lastCallback != null) {
      editController.removeListener(_lastCallback);
    }
    editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return material.TextField(
      focusNode: _focusNode,
      textAlign: widget.textAlign,
      keyboardType: widget.type,
      controller: editController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius,
            borderSide: BorderSide.none,
          ),
          labelText: widget.placeholderText),
    );
  }
}
