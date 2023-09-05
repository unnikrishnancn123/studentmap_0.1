class Student {
  int? id;
  String? name;
  String? address;
  String? email;
  String? phone;
  String? district;
  String? gender;
  String? dob;
  String? data;
  String? crtloc;

  Student({this.id, this.name, this.address, this.email, this.phone, this.district, this.gender, this.dob, this.data, this.crtloc,});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'email': email,
      'phone': phone,
      'district': district,
      'gender': gender,
      'dob': dob,
      'data': data,
      'crtloc': crtloc,
    };
  }

  static Student fromMap(Map<dynamic, dynamic> map) {
    return Student(
      id: map['id']as int,
      name: map['name'] as String ,
      address: map['address'] as String ,
      email: map['email'] as String ,
      phone: map['phone'] as String ,
      district: map['district'] as String ,
      gender: map['gender'] as String ,
      dob: map['dob'] as String ,
      data: map['data'] as String,
      crtloc: map['crtloc'] as String ,
    );
  }
}