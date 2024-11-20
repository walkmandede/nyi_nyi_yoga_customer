
enum EnumClassType{
  daily(label: "Daily",backendEnum: "Daily"),
  weekend(label: "Weekend",backendEnum: "Weekend"),
  ;
  final String label;
  final String backendEnum;
  const EnumClassType({required this.label,required this.backendEnum});
}

class ClassModel{
  String id;
  String instructor;
  DateTime startDate;
  DateTime endDate;
  String location;
  int maxStudents;
  EnumClassType enumClassType;
  String courseId;
  String courseName;
  String courseDesc;
  int duration;

  ClassModel({
    required this.id,
    required this.instructor,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.maxStudents,
    required this.enumClassType,
    required this.courseId,
    required this.courseName,
    required this.courseDesc,
    required this.duration
  });

  factory ClassModel.fromApi({required Map<String,dynamic> data}){
    return ClassModel(
      id: data["id"].toString(),
      courseId: data["course_id"].toString(),
      enumClassType: EnumClassType.values.where((element) => element.backendEnum == data["type"].toString(),).firstOrNull??EnumClassType.daily,
      location: data["location"].toString(),
      courseDesc: data["course"]==null?"-":data["course"]["description"].toString(),
      courseName: data["course"]==null?"-":data["course"]["name"].toString(),
      duration: data["course"]==null?0:int.tryParse(data["course"]["duration"].toString())??0,
      startDate: DateTime.tryParse(data["start_date"].toString())??DateTime(1),
      endDate: DateTime.tryParse(data["end_date"].toString())??DateTime(1),
      instructor: data["instructor"].toString(),
      maxStudents: int.tryParse(data["max_students"].toString())??0
    );
  }

}