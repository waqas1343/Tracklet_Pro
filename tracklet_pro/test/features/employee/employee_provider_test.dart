import 'package:flutter_test/flutter_test.dart';
import 'package:tracklet_pro/features/plant/presentation/screens/employe_screen/provider/employe_provider.dart';

void main() {
  group('EmployeeProvider', () {
    test('initial counts are consistent with employees list', () {
      final provider = EmployeeProvider();
      final present = provider.employees.where((e) => e.isPresent).length;
      final absent = provider.employees.where((e) => !e.isPresent).length;

      expect(provider.presentCount, present);
      expect(provider.absentCount, absent);
      expect(provider.totalEmployees, provider.employees.length);
    });

    test('toggleAttendance updates presence and counts', () {
      final provider = EmployeeProvider();
      final targetId = provider.employees.first.id;

      final initialPresent = provider.presentCount;
      final wasPresent = provider.employees.first.isPresent;

      // Toggle to opposite
      provider.toggleAttendance(targetId, !wasPresent);
      expect(provider.employees.first.isPresent, !wasPresent);
      expect(provider.presentCount,
          wasPresent ? initialPresent - 1 : initialPresent + 1);

      // Toggle back
      provider.toggleAttendance(targetId, wasPresent);
      expect(provider.employees.first.isPresent, wasPresent);
      expect(provider.presentCount, initialPresent);
    });
  });
}
