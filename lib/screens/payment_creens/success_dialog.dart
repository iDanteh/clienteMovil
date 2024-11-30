import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfirmationDialogPayment {
  static Future<void> showSuccessDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context); // Cierra el diálogo
          Navigator.pushNamed(context, '/products'); // Redirige
        });
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'lib/assets/animation/success.json',
                height: 150,
                width: 150,
              ),
              SizedBox(height: 20),
              Text(
                "Compra realizada exitosamente",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
