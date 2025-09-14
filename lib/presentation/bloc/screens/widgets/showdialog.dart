import 'package:flutter/material.dart';

Future<dynamic> showDialogBox({
  required BuildContext context,
  required String title,
  required String content,
  VoidCallback? cancelTap,
  VoidCallback? confirmTap,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 300, 
            maxWidth: 400, 
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.symmetric(vertical: 8),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // violet color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: confirmTap ?? () => Navigator.pop(context),
                child: const Text(
                  "Yes, Confirm!",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // red color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: cancelTap ?? () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
