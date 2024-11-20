import 'package:flutter/material.dart';

class ProfileModel{

  String id;
  String name;
  String email;
  String phone;

  ProfileModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone
  });

  factory ProfileModel.fromApi({required Map<String,dynamic> data}){
    return ProfileModel(
      id: data["id"].toString(),
      email: data["email"].toString(),
      name: data["name"].toString(),
      phone: data["password"].toString()
    );
  }

  bool isValid(){
    return id != "";
  }

}