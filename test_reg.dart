import 'dart:io';
import 'package:dio/dio.dart';

void main() async {
  final file = File('dummy.png');
  await file.writeAsBytes([
    137,
    80,
    78,
    71,
    13,
    10,
    26,
    10,
    0,
    0,
    0,
    13,
    73,
    72,
    68,
    82,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    1,
    8,
    6,
    0,
    0,
    0,
    31,
    21,
    196,
    137,
    0,
    0,
    0,
    11,
    73,
    68,
    65,
    84,
    8,
    153,
    99,
    248,
    15,
    4,
    0,
    9,
    251,
    3,
    253,
    227,
    85,
    242,
    156,
    0,
    0,
    0,
    0,
    73,
    69,
    78,
    68,
    174,
    66,
    96,
    130
  ]);

  final dio = Dio(BaseOptions(
    baseUrl: 'https://sowlab.com/assignment/',
    headers: {
      'Accept': 'application/json',
    },
    validateStatus: (s) => true,
    responseType: ResponseType.plain,
  ));

  print('--- TEST MULTIPART WITH QUERY PARAM ---');
  final formData1 = FormData();
  formData1.fields.add(MapEntry('full_name', 'Test User'));
  formData1.fields.add(MapEntry('email', 'test99991@example.com'));
  formData1.fields.add(MapEntry('phone', '1234567891'));
  formData1.fields.add(MapEntry('password', 'password123'));
  formData1.fields.add(MapEntry('role', 'farmer'));
  formData1.fields.add(MapEntry('type', 'email'));

  // also put it in body just in case
  formData1.fields.add(MapEntry('social_id', 'NA'));
  // Add missing ones from prompt
  formData1.fields.add(MapEntry('business_name', 'Test Farm'));
  formData1.fields.add(MapEntry('informal_name', 'Test Farm Inc'));
  formData1.fields.add(MapEntry('address', '123 Farm Road'));
  formData1.fields.add(MapEntry('city', 'Farmville'));
  formData1.fields.add(MapEntry('state', 'NY'));
  formData1.fields.add(MapEntry('zip_code', '12345'));
  formData1.fields.add(MapEntry('business_hours', '{}'));
  formData1.fields.add(MapEntry('device_token', 'dummy_token'));

  formData1.files.add(MapEntry('registration_proof',
      await MultipartFile.fromFile('dummy.png', filename: 'dummy.png')));

  final res1 = await dio.post('user/register?social_id=NA', data: formData1);
  final html = res1.data.toString();
  print('RESULT QUERY PARAM: ' + html);
}
