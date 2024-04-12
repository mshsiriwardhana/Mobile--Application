import 'package:flutter/material.dart';

class UnitConverter extends StatelessWidget {
  const UnitConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unit Converter',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 192, 241, 209),
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Unit Converter',
            ),
          ),
          body: const HomeScreenS(),
        ));
  }
}

// class UnitHome extends StatefulWidget {
//   const UnitHome({super.key});

//   @override
//   State<UnitHome> createState() => _UnitHomeState();
// }

// class _UnitHomeState extends State<UnitHome> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class HomeScreenS extends StatefulWidget {
  const HomeScreenS({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenSState createState() => _HomeScreenSState();
}

class _HomeScreenSState extends State<HomeScreenS> {
  final TextStyle labelStyle = const TextStyle(
    fontSize: 16.0,
  );
  final TextStyle resultSyle = const TextStyle(
    color: Color.fromARGB(255, 30, 33, 32),
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _mesaures = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms',
    'Feet',
    'Miles',
    'Pounds',
    'Ounces'
  ];

  double _value = 0.0;
  String _fromMesaures = 'Meters';
  String _toMesaures = 'Kilometers';
  String _results = "";

  final Map<String, int> _mesauresMap = {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 2,
    'Kilograms': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds': 6,
    'Ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Inter the Value',
              ),
              onChanged: (value) {
                setState(() {
                  _value = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: labelStyle,
                    ),
                    DropdownButton(
                      items: _mesaures
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _fromMesaures = value!;
                        });
                      },
                      value: _fromMesaures,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('To', style: labelStyle),
                    DropdownButton(
                      items: _mesaures
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _toMesaures = value!;
                        });
                      },
                      value: _toMesaures,
                    )
                  ],
                ),
              ],
            ),
            MaterialButton(
              minWidth: double.infinity,
              onPressed: _convert,
              color: Colors.teal,
              child: const Text(
                'Convert',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 25.0),
            Text(
              _results,
              style: resultSyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _convert() {
    // ignore: avoid_print
    print('Button Clicked');
    // ignore: avoid_print
    print(_value);

    if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
      int? from = _mesauresMap[_fromMesaures];
      int? to = _mesauresMap[_toMesaures];

      var multiplier = _formulas[from.toString()][to];

      setState(() {
        _results =
            "$_value $_fromMesaures = ${_value * multiplier} $_toMesaures";
      });
    } else {
      setState(() {
        _results = "Please enter a non zero value";
      });
    }
  }
}
