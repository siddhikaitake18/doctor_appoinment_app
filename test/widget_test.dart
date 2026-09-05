import 'package:flutter_test/flutter_test.dart';
import 'package:doctor_appoinment_app/main.dart';

void main() {
  testWidgets('Doctor Appointment App loads',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DoctorAppointmentApp());

    expect(find.text('MediBook'), findsOneWidget);
  });
}