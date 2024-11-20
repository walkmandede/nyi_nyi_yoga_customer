import 'package:flutter/material.dart';
import 'package:kmdmobilehybrid/constants/app_colors.dart';
import 'package:kmdmobilehybrid/controllers/data_controller.dart';
import 'package:kmdmobilehybrid/utils/dialog_service.dart';
import 'package:kmdmobilehybrid/utils/route_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  DataController dataController = DataController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void onClickLogOut() async{
    DialogService().showConfirmDialog(
      context: context,
      label: "Are you sure to log out?",
      yesBg: AppColors.redDanger,
      onClickYes: () {
        Navigator.pushNamedAndRemoveUntil(context, RouteUtils.loginPage,(route) => false,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        title: Text(
          "${dataController.profileModel.value.name}'s Profile",
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, RouteUtils.recordsPage);
            },
            leading: Icon(Icons.list_alt_rounded,color: AppColors.text1,),
            title: Text(
              "My booking records",
              style: TextStyle(
                color: AppColors.text1,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              onClickLogOut();
            },
            leading: Icon(Icons.logout_rounded,color: AppColors.redDanger,),
            title: Text(
              "Log Out",
              style: TextStyle(
                color: AppColors.redDanger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
