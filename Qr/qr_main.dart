import 'package:flutter/material.dart';
import 'package:todolist/Qr/qr_splash.dart';
import 'package:todolist/widgets_notepad.dart/note_home_screen.dart'; // Import your QR scanner page

void main() => runApp(CalculatorQRApp());

class CalculatorQRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator & QR Scanner",
      home: HomeScreen(),
    );
  }
}

class QrMain extends StatelessWidget {
  const QrMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' QR Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ElevatedButton(
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             Calculator(calculatorType: CalculatorType.ios12)),
            //   ),
            //   child: null,
            //   //child: Text('Calculator'),
            // ),
            SizedBox(height: 20), // Provide some spacing between buttons
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QRScannerSplashScreen()),
              ),
              child: Text('QR Scanner'),
            ),
          ],
        ),
      ),
    );
  }
}
