import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:kmdmobilehybrid/constants/app_colors.dart';
import 'package:kmdmobilehybrid/constants/app_constants.dart';
import 'package:kmdmobilehybrid/constants/app_functions.dart';
import 'package:kmdmobilehybrid/controllers/cart_controller.dart';
import 'package:kmdmobilehybrid/controllers/data_controller.dart';
import 'package:kmdmobilehybrid/models/booking_model.dart';
import 'package:kmdmobilehybrid/models/class_model.dart';
import 'package:kmdmobilehybrid/utils/api/api_end_points.dart';
import 'package:kmdmobilehybrid/utils/api/api_service.dart';
import 'package:kmdmobilehybrid/utils/route_utils.dart';
import 'package:kmdmobilehybrid/views/common/class_widget.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {

  DataController dataController = DataController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  List<BookingModel> allData = [];

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> initLoad() async{
    isLoading.value = true;
    await updateData();
    isLoading.value = false;
  }

  Future<void> updateData() async{
    Response? response;
    allData.clear();
    try{
      DataController dataController = DataController();
      response = await ApiService().get(endPoint: ApiEndPoints.getRecordsByStudentId+dataController.profileModel.value.id);
    }
    catch(_){}

    final apiResponse = ApiService().validateResponse(response: response);
    if(apiResponse.isSuccess){
      superPrint(apiResponse.bodyData,title: apiResponse.isSuccess);
      Iterable data = apiResponse.bodyData["data"]??[];
      for(final each in data){
        final model = BookingModel.fromApi(data: each);
        allData.add(model);
        superPrint(allData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg1,
        appBar: AppBar(
          title: Text(
            "My Records"
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (context, isLoading, child) {
            if(isLoading){
              return const Center(
                child: CupertinoActivityIndicator(color: AppColors.primary,),
              );
            }
            else{
              if(allData.isEmpty){
                return RefreshIndicator(
                  onRefresh: () async{
                    await updateData();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: AppFunctions.getMediaQuerySize(context: context).height,
                          child: const Center(
                            child: Text(
                              "No Data",
                              style: TextStyle(
                                  color: AppColors.text2
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async{
                  await updateData();
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      // vertical: AppConstants.basePadding,
                      // horizontal: AppConstants.basePadding
                  ),
                  itemCount: allData.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: AppConstants.basePadding*0.5,);
                  },
                  itemBuilder: (context, index) {
                    final each = allData[index];
                    return ListTile(
                      title: Text(
                        "You booked ${each.classModel.instructor}'s class\n${DateFormat.yMMMd().format(each.classModel.startDate)} - ${DateFormat.yMMMd().format(each.classModel.endDate)}",
                        style: const TextStyle(
                          color: AppColors.text1
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd().format(each.createAt),
                        style: const TextStyle(
                          color: AppColors.grey
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        )
    );
  }
}
