
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kujitoon/main.dart';

class WebToast {
  static void showSuccess(String message) {
    _show(message, Colors.green, Icons.check_circle);
  }

  static void showError(String message) {
    _show(message, Colors.red, Icons.error);
  }

  static void showWarning(String message) {
    _show(message, Colors.orange, Icons.warning);
  }

  static void _show(String message, Color color, IconData icon) {
    final overlayState = navigatorKey.currentState?.overlay;
    if (overlayState == null) return;

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 20,
          right: 20,
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 22),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    overlayState.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2)).then((_) {
      overlayEntry.remove();
    });
  }
}
