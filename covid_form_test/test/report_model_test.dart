import 'package:flutter_test/flutter_test.dart';
import 'package:covid_form/Model/report_model.dart';

void main() {
  test('Report toJson and fromJson', () {
    final report = Report(
      firstname: 'ปอนด์',
      lastname: 'สุดหล่อ',
      nickname: 'เทพค้างคาว',
      gender: 'Male',
      age: 21,
      syntoms: ['ไอ', 'ไข้'],
    );

    final json = report.toJson();
    expect(json['firstname'], 'ปอนด์');
    expect(json['syntoms'], contains('ไอ'));

    final newReport = Report.fromJson(json);
    expect(newReport.firstname, 'ปอนด์');
    expect(newReport.syntoms, contains('ไอ'));
  });
}
