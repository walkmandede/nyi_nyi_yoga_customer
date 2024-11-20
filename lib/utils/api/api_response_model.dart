class ApiResponse{

  int statusCode;
  dynamic bodyData;
  String? bodyString;
  String message;
  bool isSuccess;

  ApiResponse({
    required this.statusCode,
    required this.bodyData,
    required this.bodyString,
    required this.message,
    required this.isSuccess
  });

  factory ApiResponse.getInstance(){
    return ApiResponse(
        bodyData: null,
        bodyString: null,
        message: "",
        statusCode: 0,
        isSuccess: false
    );
  }

}