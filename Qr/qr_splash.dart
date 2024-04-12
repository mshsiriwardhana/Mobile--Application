// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:todolist/Qr/qr_Scanner.dart';
// ignore: unused_import
import 'scanner.dart'; // Import the actual QR scanner page

class QRScannerSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          // This will center the Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Centers vertically and distribute space evenly
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centers horizontally
            children: [
              Text(
                'Scan your QR Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Ensure text is center-aligned
              ),
              Image.asset(
                'assets/qr_placeholder.png', // Replace with your QR code asset
                width: 200.0, // Set any size you like
                height: 200.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Colors.green, // Text Color (Foreground color)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            QRScanPage()), // Navigate to the QR scanner page
                  );
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                  child: Text(
                    'Scan QR Code',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
