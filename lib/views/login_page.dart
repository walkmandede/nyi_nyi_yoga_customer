import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kmdmobilehybrid/constants/app_colors.dart';
import 'package:kmdmobilehybrid/constants/app_constants.dart';
import 'package:kmdmobilehybrid/constants/app_functions.dart';
import 'package:kmdmobilehybrid/controllers/data_controller.dart';
import 'package:kmdmobilehybrid/models/profile_model.dart';
import 'package:kmdmobilehybrid/utils/api/api_end_points.dart';
import 'package:kmdmobilehybrid/utils/api/api_response_model.dart';
import 'package:kmdmobilehybrid/utils/api/api_service.dart';
import 'package:kmdmobilehybrid/utils/route_utils.dart';

import '../utils/dialog_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController txtEmail = TextEditingController(text: "");
  TextEditingController txtPassword = TextEditingController(text: "");

  Future<void> onClickLogin() async{

    if(!AppFunctions.isValidEmail(txtEmail.text)){
      DialogService().showConfirmDialog(
          context: context,
          label: "Invalid Email"
      );
    }
    else if(txtPassword.text.isEmpty){
      DialogService().showConfirmDialog(
          context: context,
          label: "Password is too short"
      );
    }
    else{
      DialogService().showLoadingDialog(context: context);
      Response? response;
      try{
        response = await ApiService().post(
            endPoint: ApiEndPoints.postLogin,
            data: {
              "email" : txtEmail.text,
              "password" : txtPassword.text
            }
        );
      }
      catch(_){}
      DialogService().dismissDialog(context: context);
      superPrint(response);
      ApiResponse apiResponse = ApiService().validateResponse(response: response);

      if(apiResponse.isSuccess){
        DataController dataController = DataController();
        dataController.profileModel.value = ProfileModel.fromApi(data: apiResponse.bodyData["data"]);
        Navigator.pushNamedAndRemoveUntil(context, RouteUtils.homePage, (route) => false,);
      }
      else{
        DialogService().showConfirmDialog(context: context,label: apiResponse.message);
      }

     }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        title: const Text(
          "Log In"
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.basePadding,
            vertical: AppConstants.basePadding
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              TextField(
                controller: txtEmail,
                style: const TextStyle(
                  color: AppColors.text1,
                  fontSize: AppConstants.baseFontSizeXL
                ),
                onTapOutside: (event) {
                  dismissKeyboard();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  label: Text(
                    "Email",
                    style: TextStyle(
                      color: AppColors.text2,
                      fontWeight: FontWeight.w600,
                      fontSize: AppConstants.baseFontSizeXL
                    ),
                  )
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtPassword,
                style: const TextStyle(
                  color: AppColors.text1,
                  fontSize: AppConstants.baseFontSizeXL
                ),
                onTapOutside: (event) {
                  dismissKeyboard();
                },
                obscureText: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  label: Text(
                    "Password",
                    style: TextStyle(
                      color: AppColors.text2,
                      fontWeight: FontWeight.w600,
                      fontSize: AppConstants.baseFontSizeXL
                    ),
                  )
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: AppConstants.baseButtonHeightMS,
                child: ElevatedButton(
                  onPressed: () {
                    onClickLogin();
                  },
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppConstants.baseFontSizeL
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {
                  Navigator.pushNamed(context, RouteUtils.registerPage);
                }, child: Text(
                    "Register Now",
                  style: TextStyle(
                    color: AppColors.primary
                  ),
                )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
