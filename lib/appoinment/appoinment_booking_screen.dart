import 'package:flutter/material.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState
    extends State<AppointmentBookingScreen> {
  DateTime? selectedDate;
  String? selectedTime;

  final List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void confirmBooking() {
    if (selectedDate == null) {
      showMessage('Please select a date');
      return;
    }

    if (selectedTime == null) {
      showMessage('Please select a time');
      return;
    }

    if (nameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        emailController.text.isEmpty) {
      showMessage('Please fill all required details');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking Confirmed'),
          content: const Text(
            'Your appointment has been booked successfully!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Doctor / Service',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text('Dr. John Smith'),
                subtitle: const Text('General Physician'),
                trailing: const Text('₹500'),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              '1. Select Date',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: selectDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : '${selectedDate!.day}/'
                          '${selectedDate!.month}/'
                          '${selectedDate!.year}',
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              '2. Select Time',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((time) {
                final isSelected = selectedTime == time;

                return ChoiceChip(
                  label: Text(time),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            const Text(
              '3. Enter Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Reason / Description',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              '4. Booking Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doctor: Dr. John Smith',
                    ),
                    Text(
                      'Date: ${selectedDate == null ? 'Not selected' : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'}',
                    ),
                    Text(
                      'Time: ${selectedTime ?? 'Not selected'}',
                    ),
                    const Text('Fee: ₹500'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: confirmBooking,
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}