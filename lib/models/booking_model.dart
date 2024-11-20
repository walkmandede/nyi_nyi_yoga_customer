
import 'package:kmdmobilehybrid/models/class_model.dart';

class BookingModel{
  String id;
  DateTime createAt;
  ClassModel classModel;

  BookingModel({required this.classModel,required this.id,required this.createAt});

  factory BookingModel.fromApi({required Map<String,dynamic> data}){
    return BookingModel(
      id: data["id"].toString(),
      createAt: DateTime.tryParse(data["created_at"].toString())??DateTime(0),
      classModel: ClassModel.fromApi(data: data["class"]??{})
    );
  }

}