import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kmdmobilehybrid/constants/app_colors.dart';
import 'package:kmdmobilehybrid/constants/app_constants.dart';
import 'package:kmdmobilehybrid/controllers/cart_controller.dart';
import 'package:kmdmobilehybrid/models/class_model.dart';

class ClassWidget extends StatelessWidget {
  final ClassModel classModel;
  final bool isMini;
  const ClassWidget({super.key,required this.classModel,this.isMini = false});

  @override
  Widget build(BuildContext context) {
    CartController cartController = CartController();
    return ValueListenableBuilder(
      valueListenable: cartController.selectedData,
      builder: (context, selectedData, child) {
        final isAlreadyInCart = cartController.isAlreadyInCart(model: classModel);
        return InkWell(
          onTap: () {
            cartController.toggleItem(model: classModel);
          },
          child: Card(
            color: isAlreadyInCart?AppColors.primary.withOpacity(0.1):AppColors.bg2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
              side: BorderSide(
                color: isAlreadyInCart?AppColors.primary:AppColors.bg2
              )
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.basePadding,
                    vertical: AppConstants.basePadding*0.5
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            classModel.courseName,
                            style: const TextStyle(
                                color: AppColors.text1,
                                fontWeight: FontWeight.w600,
                                fontSize: AppConstants.baseFontSizeM
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Chip(
                          backgroundColor: AppColors.primary,
                          label: Text(
                            "${classModel.location}- ${classModel.enumClassType.label}",
                            style: const TextStyle(
                                color: AppColors.primaryOver,
                                fontSize: AppConstants.baseFontSizeS,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ],
                    ),
                    if(!isMini)Text(
                      classModel.courseDesc,
                      style: const TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: AppConstants.baseFontSizeS
                      ),
                    ),
                    if(!isMini)const Divider(color: AppColors.textFieldBg,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${DateFormat("MMM dd, yyyy").format(classModel.startDate)} - ${DateFormat("MMM dd, yyyy").format(classModel.endDate)} ",
                        style: const TextStyle(
                            color: AppColors.text2,
                            fontWeight: FontWeight.normal,
                            fontSize: AppConstants.baseFontSizeXs
                        ),
                      ),
                    ),
                    const SizedBox(height: 6,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person_rounded,
                                color: AppColors.text2,
                              ),
                              const SizedBox(width: 5,),
                              Flexible(
                                child: Text(
                                  classModel.instructor,
                                  style: const TextStyle(
                                      color: AppColors.text2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: AppConstants.baseFontSizeS
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.people_rounded,
                                color: AppColors.text2,
                              ),
                              const SizedBox(width: 5,),
                              Flexible(
                                child: Text(
                                  "${classModel.maxStudents.toString()}",
                                  style: const TextStyle(
                                      color: AppColors.text2,
                                      fontWeight: FontWeight.normal,
                                      fontSize: AppConstants.baseFontSizeS
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
