import 'package:flutter/material.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() =>
      _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState
    extends State<MyAppointmentsScreen> {
  List<Map<String, String>> upcomingAppointments = [
    {
      'doctor': 'Dr. John Smith',
      'specialization': 'General Physician',
      'date': '25 Aug 2026',
      'time': '10:00 AM',
      'status': 'Upcoming',
    },
    {
      'doctor': 'Dr. Sarah Williams',
      'specialization': 'Cardiologist',
      'date': '28 Aug 2026',
      'time': '02:00 PM',
      'status': 'Upcoming',
    },
  ];

  List<Map<String, String>> completedAppointments = [
    {
      'doctor': 'Dr. Michael Brown',
      'specialization': 'Dermatologist',
      'date': '10 Aug 2026',
      'time': '11:00 AM',
      'status': 'Completed',
    },
  ];

  List<Map<String, String>> cancelledAppointments = [];

  void cancelAppointment(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel Appointment'),
          content: const Text(
            'Are you sure you want to cancel this appointment?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                final appointment =
                    upcomingAppointments[index];

                setState(() {
                  upcomingAppointments.removeAt(index);

                  cancelledAppointments.add({
                    ...appointment,
                    'status': 'Cancelled',
                  });
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Appointment cancelled successfully',
                    ),
                  ),
                );
              },
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget appointmentCard(
    Map<String, String> appointment, {
    bool showCancelButton = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment['doctor'] ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(appointment['specialization'] ?? ''),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 18),
                const SizedBox(width: 6),
                Text(appointment['date'] ?? ''),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 6),
                Text(appointment['time'] ?? ''),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Status: ${appointment['status']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showCancelButton) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    final index =
                        upcomingAppointments.indexOf(appointment);

                    cancelAppointment(index);
                  },
                  child: const Text('Cancel Appointment'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget appointmentList(
    List<Map<String, String>> appointments, {
    bool showCancelButton = false,
  }) {
    if (appointments.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            'No appointments available.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return appointmentCard(
          appointments[index],
          showCancelButton: showCancelButton,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Appointments'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            appointmentList(
              upcomingAppointments,
              showCancelButton: true,
            ),
            appointmentList(
              completedAppointments,
            ),
            appointmentList(
              cancelledAppointments,
            ),
          ],
        ),
      ),
    );
  }
}