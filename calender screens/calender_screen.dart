import 'package:flutter/material.dart';
import 'package:todolist/calender%20screens/add_appointment_screens.dart';
import '../models/appointment.dart';

import 'view_appointments_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  List<Appointment> _appointments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar App'),
      ),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: _selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
            onDateChanged: (newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _navigateToAddAppointmentScreen(context);
            },
            child: Text('Add Appointment'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _navigateToViewAppointmentsScreen(context);
            },
            child: Text('View Appointments'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddAppointmentScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddAppointmentScreen(onSave: _saveAppointment)),
    );

    if (result != null && result is Appointment) {
      setState(() {
        _appointments.add(result);
      });
    }
  }

  void _navigateToViewAppointmentsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ViewAppointmentsScreen(appointments: _appointments)),
    );
  }

  void _saveAppointment(Appointment appointment) {
    setState(() {
      _appointments.add(appointment);
    });
  }
}
