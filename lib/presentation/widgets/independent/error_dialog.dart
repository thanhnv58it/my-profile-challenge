import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_profile/config/theme.dart';

class ErrorDialog extends StatelessWidget {
  final String mainText;

  const ErrorDialog({super.key, required this.mainText});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: const Icon(
                CupertinoIcons.exclamationmark_circle,
                color: AppColors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(mainText,
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error)),
          ),
          const SizedBox(
            height: 24.0,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: const BoxDecoration(
                color: AppColors.backgroundLight,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'OK',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future showErrorDialog(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return Theme(
              data: ThemeData(dialogBackgroundColor: AppColors.background),
              child: AlertDialog(
                  contentPadding: const EdgeInsets.all(16.0),
                  content: ErrorDialog(
                    mainText: text,
                  )));
        });
  }
}
