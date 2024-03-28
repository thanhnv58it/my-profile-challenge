import 'package:flutter/material.dart';

class BasicTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final bool isSecure;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;

  const BasicTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.prefixIcon,
      required this.controller,
      required this.isSecure,
      required this.keyboardType,
      required this.validator});

  @override
  State<BasicTextField> createState() => BasicTextFieldState();
}

class BasicTextFieldState extends State<BasicTextField> {
  bool _showSuffixIcon = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showSuffixIcon = widget.controller.text.isNotEmpty;
      _errorText = widget.validator(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isSecure,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: _showSuffixIcon
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    widget.controller.clear();
                  },
                )
              : null,
          errorText: _errorText,
        ),
      ),
    );
  }

  String? validate() {
    setState(() {
      _errorText = widget.validator(widget.controller.text);
    });
    return _errorText;
  }
}
