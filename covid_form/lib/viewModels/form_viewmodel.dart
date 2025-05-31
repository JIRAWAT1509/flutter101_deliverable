import 'package:flutter/material.dart';
import '../Model/report_model.dart';

class FormViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final nicknameController = TextEditingController();
  final ageController = TextEditingController();

  String? selectedGender;
  List<String> selectedSyntoms = [];

  void toggleSymptom(String symptom) {
    if (selectedSyntoms.contains(symptom)) {
      selectedSyntoms.remove(symptom);
    } else {
      selectedSyntoms.add(symptom);
    }
    notifyListeners();
  }

  void setGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  Report? getReport() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return Report(
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        nickname: nicknameController.text,
        gender: selectedGender,
        age: int.tryParse(ageController.text),
        syntoms: selectedSyntoms,
      );
    }
    return null;
  }

  void resetForm() {
    firstnameController.clear();
    lastnameController.clear();
    nicknameController.clear();
    ageController.clear();
    selectedGender = null;
    selectedSyntoms.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    nicknameController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
