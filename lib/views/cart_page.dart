import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kmdmobilehybrid/constants/app_colors.dart';
import 'package:kmdmobilehybrid/constants/app_constants.dart';
import 'package:kmdmobilehybrid/constants/app_functions.dart';
import 'package:kmdmobilehybrid/controllers/cart_controller.dart';
import 'package:kmdmobilehybrid/controllers/data_controller.dart';
import 'package:kmdmobilehybrid/utils/api/api_end_points.dart';
import 'package:kmdmobilehybrid/utils/api/api_service.dart';
import 'package:kmdmobilehybrid/utils/dialog_service.dart';
import 'package:kmdmobilehybrid/utils/route_utils.dart';
import 'package:kmdmobilehybrid/views/common/class_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  Future<void> bookNow() async{

    bool isSuccess = false;
    DataController dataController = DataController();
    CartController cartController = CartController();

    if(cartController.selectedData.value.isEmpty){
      DialogService().showConfirmDialog(context: context,label: "No class in the cart!\nAdd some classes to continue");
      return;
    }

    DialogService().showLoadingDialog(context: context);
    try{
      for(final each in cartController.selectedData.value){
        Response? response;
        try{
          response = await ApiService().post(
            endPoint: ApiEndPoints.postEnrol,
            data: {
              "student_id" : dataController.profileModel.value.id,
              "course_class_id" : each.id,
            }
          );
        }
        catch(_){}
        final apiResponse = ApiService().validateResponse(response: response);
        if(apiResponse.isSuccess){
          isSuccess = true;
        }
        else{
          isSuccess = false;
          break;
        }
      }
    }
    catch(e){
      //
    }
    DialogService().dismissDialog(context: context);

    if(isSuccess){
      cartController.clearCart();
      Navigator.pushNamedAndRemoveUntil(context, RouteUtils.homePage, (route) => false,);
      Navigator.pushNamed(context, RouteUtils.recordsPage);
    }
    else{
      DialogService().showConfirmDialog(
        context: context,
        label: "Something went wrong!",
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    CartController cartController = CartController();


    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        title: const Text(
          "My Cart",
        ),
      ),
      body: SizedBox.expand(
        child: ValueListenableBuilder(
          valueListenable: cartController.selectedData,
          builder: (context, selectedData, child) {
            return Column(
              children: [
                Expanded(
                  child: _classListWidget(),
                ),
                _priceListWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  _classListWidget() {
    CartController cartController = CartController();
    return ListView.separated(
      itemCount: cartController.selectedData.value.length,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.basePadding,
        vertical: AppConstants.basePadding
      ),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: AppConstants.basePadding*0.5,
        );
      },

      itemBuilder: (context, index) {
        final each  = cartController.selectedData.value[index];
        return ClassWidget(classModel: each,isMini: true,);
      },
    );
  }

  _priceListWidget() {
    CartController cartController = CartController();
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.baseBorderRadius)
        )
      ),
      color: AppColors.bg2,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.basePadding,
            vertical: AppConstants.basePadding
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Total Classes : ",
                      style: TextStyle(
                          color: AppColors.text2,
                          fontSize: AppConstants.baseFontSizeM
                      ),
                    ),
                  ),
                  Text(
                    "${cartController.selectedData.value.length} class(es)",
                    style: const TextStyle(
                        color: AppColors.text1,
                        fontSize: AppConstants.baseFontSizeM
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                height: AppConstants.baseButtonHeightMS,
                child: ElevatedButton(
                  onPressed: () {
                    bookNow();
                  },
                  child: const Text("Book Now"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
