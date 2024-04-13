import 'package:flutter/material.dart';
import '../models/appointment.dart';

class ViewAppointmentsScreen extends StatelessWidget {
  final List<Appointment> appointments;

  ViewAppointmentsScreen({required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Appointments'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appointments[index].title),
            subtitle: Text(appointments[index].date.toString()),
          );
        },
      ),
    );
  }
}
