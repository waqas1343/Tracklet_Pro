import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/widgets/attendance_list.dart';

void main() {
  testWidgets('Tapping chips updates provider counts', (tester) async {
    // Arrange
    final provider = EmployeeProvider();
    final initialPresent = provider.presentCount;
    final firstEmp = provider.employees.first;

    await tester.pumpWidget(
      ChangeNotifierProvider<EmployeeProvider>.value(
        value: provider,
        child: const MaterialApp(
          home: Scaffold(
            body: AttendanceList(),
          ),
        ),
      ),
    );

    // Act: toggle first employee to the opposite state via tapping the appropriate chip
    if (firstEmp.isPresent) {
      // Make Absent
      await tester.tap(find.text('Absent').first);
    } else {
      // Make Present
      await tester.tap(find.text('Present').first);
    }
    await tester.pump();

    // Assert: presentCount should change by -1 or +1 accordingly
    expect(
      provider.presentCount,
      firstEmp.isPresent ? initialPresent - 1 : initialPresent + 1,
    );
  });
}
