class UserModel {
  final int userId;
  final int? clinicId;
  final int? doctorId;
  final List<DoctorClinicModel>? doctorClinics;
  final String firstName;
  final String? middleName;
  final String lastName;
  final int? age;
  final String? gender;
  final String? designation;
  final String contactNo;
  final String? address;
  final String? city;
  final String? district;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? profilePicture;
  final String email;

  UserModel({
    required this.userId,
    this.clinicId,
    this.doctorId,
    this.doctorClinics,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.age,
    this.gender,
    this.designation,
    required this.contactNo,
    this.address,
    this.city,
    this.district,
    this.state,
    this.country,
    this.postalCode,
    this.profilePicture,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: int.parse(json['userId'].toString()),   // ✅ always safe
      clinicId: json['clinicId'] != null ? int.tryParse(json['clinicId'].toString()) : null,
      doctorId: json['doctorId'] != null ? int.tryParse(json['doctorId'].toString()) : null,
      doctorClinics: (json['doctorClinics'] as List?)
          ?.map((e) => DoctorClinicModel.fromJson(e))
          .toList(),
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'],
      lastName: json['lastName'] ?? '',
      age: json['age'] != null ? int.tryParse(json['age'].toString()) : null,
      gender: json['gender'],
      designation: json['designation'],
      contactNo: json['contactNo'] ?? '',
      address: json['address'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
      profilePicture: json['profilePicture'],
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'clinicId': clinicId,
      'doctorId': doctorId,
      'doctorClinics': doctorClinics?.map((e) => e.toJson()).toList(),
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'designation': designation,
      'contactNo': contactNo,
      'address': address,
      'city': city,
      'district': district,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'profilePicture': profilePicture,
      'email': email,
    };
  }
}

class DoctorClinicModel {
  final int clinicId;
  final String name;

  DoctorClinicModel({
    required this.clinicId,
    required this.name,
  });

  factory DoctorClinicModel.fromJson(Map<String, dynamic> json) {
    return DoctorClinicModel(
      clinicId: int.parse(json['clinicId'].toString()),
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinicId': clinicId,
      'name': name,
    };
  }
}
