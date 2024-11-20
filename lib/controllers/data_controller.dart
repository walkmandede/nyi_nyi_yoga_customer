import 'package:flutter/cupertino.dart';
import '../models/profile_model.dart';

class DataController {

  DataController._privateConstructor();
  static final DataController _instance = DataController._privateConstructor();

  factory DataController() {
    return _instance;
  }

  ValueNotifier<ProfileModel> profileModel = ValueNotifier(ProfileModel(
    id: "",
    phone: "",
    name: "",
    email: ""
  ));


}