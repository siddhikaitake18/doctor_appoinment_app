import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailsScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Image
            const Center(
              child: CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 70,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Doctor Name
            Center(
              child: Text(
                doctor['name'],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Text(
                doctor['specialization'],
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Rating
            InfoCard(
              icon: Icons.star,
              title: 'Rating',
              value: '${doctor['rating']} / 5.0',
            ),

            // Experience
            InfoCard(
              icon: Icons.work_outline,
              title: 'Experience',
              value: doctor['experience'],
            ),

            // Location
            InfoCard(
              icon: Icons.location_on_outlined,
              title: 'Location',
              value: doctor['location'],
            ),

            // Consultation Fee
            InfoCard(
              icon: Icons.currency_rupee,
              title: 'Consultation Fee',
              value: doctor['fee'],
            ),

            const SizedBox(height: 20),

            const Text(
              'About Doctor',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'This doctor provides professional healthcare services '
              'and consultation. Patients can book an appointment '
              'according to the available date and time slots.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Available Days',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                DayChip(title: 'Monday'),
                DayChip(title: 'Tuesday'),
                DayChip(title: 'Wednesday'),
                DayChip(title: 'Friday'),
                DayChip(title: 'Saturday'),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Available Time',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                TimeChip(title: '09:00 AM'),
                TimeChip(title: '10:00 AM'),
                TimeChip(title: '11:00 AM'),
                TimeChip(title: '02:00 PM'),
                TimeChip(title: '03:00 PM'),
                TimeChip(title: '04:00 PM'),
              ],
            ),

            const SizedBox(height: 30),

            // Book Appointment
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Appointment booking will be available soon.',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text(
                  'Book Appointment',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }
}

class DayChip extends StatelessWidget {
  final String title;

  const DayChip({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(title),
      avatar: const Icon(
        Icons.calendar_today,
        size: 16,
      ),
    );
  }
}

class TimeChip extends StatelessWidget {
  final String title;

  const TimeChip({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(title),
      avatar: const Icon(
        Icons.access_time,
        size: 16,
      ),
    );
  }
}