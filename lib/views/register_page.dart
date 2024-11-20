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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController txtName = TextEditingController(text: "");
  TextEditingController txtPhone = TextEditingController(text: "");
  TextEditingController txtEmail = TextEditingController(text: "");
  TextEditingController txtPassword = TextEditingController(text: "");

  Future<void> onClickRegisterNow() async{

    if(txtName.text.isEmpty){
      DialogService().showConfirmDialog(
          context: context,
          label: "Name should not be blank"
      );
    }
    else if(txtPhone.text.length < 6){
      DialogService().showConfirmDialog(
          context: context,
          label: "Phone number is too short"
      );
    }
    else if(!AppFunctions.isValidEmail(txtEmail.text)){
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
            endPoint: ApiEndPoints.postRegister,
            data: {
              "name" : txtName.text,
              "phone" : txtPhone.text,
              "email" : txtEmail.text,
              "password" : txtPassword.text,
            }
        );
      }
      catch(_){}
      DialogService().dismissDialog(context: context);
      ApiResponse apiResponse = ApiService().validateResponse(response: response);
      if(apiResponse.isSuccess){
        Navigator.pushNamedAndRemoveUntil(context, RouteUtils.loginPage, (route) => false,);
        DialogService().showConfirmDialog(
          context: context,
          label: "Registration Success\nPlease, Log In to Continue!"
        );
      }
      else{
        DialogService().showConfirmDialog(
            context: context,
            label: apiResponse.message
        );
      }

   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        title: const Text(
            "Register"
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
                controller: txtName,
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
                      "Name",
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
                controller: txtPhone,
                style: const TextStyle(
                    color: AppColors.text1,
                    fontSize: AppConstants.baseFontSizeXL
                ),
                onTapOutside: (event) {
                  dismissKeyboard();
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      "Phone",
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
                    onClickRegisterNow();
                  },
                  child: const Text(
                    "Register Now",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppConstants.baseFontSizeL
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
