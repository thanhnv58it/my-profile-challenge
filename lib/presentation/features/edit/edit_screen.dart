import 'package:flutter/material.dart';

import '../../widgets/independent/custom_button.dart';

class EditScreen extends StatefulWidget {
  final String title;

  final String userInfor;

  const EditScreen({
    Key? key,
    required this.title,
    required this.userInfor,
  }) : super(key: key);

  @override
  EditScreenState createState() => EditScreenState();
}

class EditScreenState extends State<EditScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.userInfor);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        if (widget.userInfor == _controller.text) {
          //We should back as nothing have been edited.
          Navigator.pop(context);
          return;
        }
        final shouldPop = await _showLeaveConfirmationDialog(context);
        if (shouldPop == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Information'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: null, // Allow multiple lines
                  decoration: InputDecoration(
                    labelText: widget.title,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24.0),
                OpenFlutterButton(
                  height: 44,
                  title: 'SAVE',
                  onPressed: () {
                    Navigator.of(context).pop(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showLeaveConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text(
              'Are you sure you want to leave this page without saving?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
