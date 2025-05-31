// views/form_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/form_viewmodel.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FormViewModel>(context);
    return Scaffold(
      key: Key("form-page-tag"),
      appBar: AppBar(title: Text('กรอกประวัติคนไข้')),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: vm.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  key: Key("firstname-tag"),
                  controller: vm.firstnameController,
                  decoration: InputDecoration(labelText: 'ชื่อ'),
                  validator: (value) => value!.isEmpty ? 'ต้องการข้อมูล' : null,
                ),
                TextFormField(
                  key: Key("lastname-tag"),

                  controller: vm.lastnameController,
                  decoration: InputDecoration(labelText: 'นามสกุล'),
                  validator: (value) => value!.isEmpty ? 'ต้องการข้อมูล' : null,
                ),
                TextFormField(
                  key: Key("nickname-tag"),

                  controller: vm.nicknameController,
                  decoration: InputDecoration(labelText: 'ชื่อเล่น'),
                  validator: (value) => value!.isEmpty ? 'ต้องการข้อมูล' : null,
                ),
                TextFormField(
                  key: Key("age-tag"),

                  controller: vm.ageController,
                  decoration: InputDecoration(labelText: 'อายุ'),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    Radio(
                      key: Key("male-tag"),
                      value: 'Male',
                      groupValue: vm.selectedGender,
                      onChanged: vm.setGender,
                    ),
                    Text('ชาย'),
                    Radio(
                      key: Key("female-tag"),
                      value: 'Female',
                      groupValue: vm.selectedGender,
                      onChanged: vm.setGender,
                    ),
                    Text('หญิง'),
                  ],
                ),
                CheckboxListTile(
                  key: Key('syntom-one-tag'),
                  title: Text('ไอ'),
                  value: vm.selectedSyntoms.contains('ไอ'),
                  onChanged: (_) => vm.toggleSymptom('ไอ'),
                ),
                CheckboxListTile(
                  key: Key('syntom-two-tag'),
                  title: Text('เจ็บคอ'),
                  value: vm.selectedSyntoms.contains('เจ็บคอ'),
                  onChanged: (_) => vm.toggleSymptom('เจ็บคอ'),
                ),
                CheckboxListTile(
                  key: Key('syntom-three-tag'),
                  title: Text('ไข้'),
                  value: vm.selectedSyntoms.contains('มีไข้'),
                  onChanged: (_) => vm.toggleSymptom('มีไข้'),
                ),
                CheckboxListTile(
                  key: Key('syntom-four-tag'),
                  title: Text('เสมหะ'),
                  value: vm.selectedSyntoms.contains('เสมหะ'),
                  onChanged: (_) => vm.toggleSymptom('เสมหะ'),
                ),
                ElevatedButton(
                  key: Key("save-button-tag"),
                  onPressed: () {
                    final report = vm.getReport();
                    if (report != null) {
                      // ???
                      vm.resetForm();
                    }
                  },
                  child: Text('บันทึกข้อมูล'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
