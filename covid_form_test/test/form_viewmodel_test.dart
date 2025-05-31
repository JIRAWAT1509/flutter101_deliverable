import 'package:flutter_test/flutter_test.dart';
import 'package:covid_form/viewmodels/form_viewmodel.dart';

void main() {
  group('FormViewModel Tests', () {
    late FormViewModel vm;

    setUp(() {
      vm = FormViewModel();
    });

    test('Initial values are correct', () {
      expect(vm.firstnameController.text, '');
      expect(vm.lastnameController.text, '');
      expect(vm.nicknameController.text, '');
      expect(vm.ageController.text, '');
      expect(vm.selectedGender, isNull);
      expect(vm.selectedSyntoms, isEmpty);
    });

    test('Toggle symptoms', () {
      vm.toggleSymptom('ไอ');
      expect(vm.selectedSyntoms.contains('ไอ'), isTrue);

      vm.toggleSymptom('ไอ');
      expect(vm.selectedSyntoms.contains('ไอ'), isFalse);
    });

    test('Set gender', () {
      vm.setGender('Male');
      expect(vm.selectedGender, 'Male');

      vm.setGender('Female');
      expect(vm.selectedGender, 'Female');
    });

    test('Reset form clears everything', () {
      vm.firstnameController.text = 'ปอนด์';
      vm.selectedGender = 'Male';
      vm.selectedSyntoms.add('ไอ');

      vm.resetForm();

      expect(vm.firstnameController.text, '');
      expect(vm.selectedGender, isNull);
      expect(vm.selectedSyntoms, isEmpty);
    });
  });
}
