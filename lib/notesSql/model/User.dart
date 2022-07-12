// ignore_for_file: file_names

import 'package:intl/intl.dart';

const String easyreg = 'easyreg';

class Registration {
  static final List<String> values = [
    id,
    name,
    age,
    gender,
    church,
    churchCity,
    churchState,
    time
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String age = 'age';
  static const String gender = 'gender';
  static const String church = 'church';
  static const String churchCity = 'churchCity';
  static const String churchState = 'churchState';
  static const String time = 'time';
}

class UserModels {
  final int? id;
  final String? name;
  final String? age;
  final String? gender;
  final String? church;
  final String? churchCity;
  final String? churchState;
  final DateTime createdTime;

  UserModels({
    required this.id,
    required this.age,
    required this.name,
    required this.gender,
    required this.church,
    required this.churchCity,
    required this.churchState,
    required this.createdTime,
  });

  static UserModels fromJson(Map<String, Object?> json) => UserModels(
      id: json[Registration.id] as int?,
      name: json[Registration.name] as String,
      age: json[Registration.age] as String,
      gender: json[Registration.gender] as String,
      church: json[Registration.church] as String,
      churchCity: json[Registration.churchCity] as String,
      churchState: json[Registration.churchState] as String,
      createdTime: _validateDate(json[Registration.time] as String?));

  Map<String, String> toJson({bool withID = false}) => {
        if (withID) Registration.id: id.toString(),
        Registration.name: name ?? '',
        Registration.age: age ?? '',
        Registration.church: church ?? '',
        Registration.churchCity: churchCity ?? '',
        Registration.churchState: churchState ?? '',
        Registration.gender: gender ?? '',
        Registration.time: createdTime.toIso8601String(),
      };

  static DateTime _validateDate(String? input,
      {String format = 'yyyyy-MM-dd'}) {
    if (input == null) {
      return DateTime.now();
    }
    try {
      return DateFormat(format).parse(input);
    } catch (e) {
      return DateTime.now();
    }
  }

  UserModels copyWith({
    int? id,
    String? name,
    String? age,
    String? gender,
    String? church,
    String? churchCity,
    String? churchState,
    DateTime? createdTime,
  }) {
    return UserModels(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      church: church ?? this.church,
      churchCity: churchCity ?? this.churchCity,
      churchState: churchState ?? this.churchState,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}
