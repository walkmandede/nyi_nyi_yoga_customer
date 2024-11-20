import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

DialogRoute? dialogRoute;


class DialogService {

  void dismissDialog({required BuildContext context}) {
    try {
      if (dialogRoute != null) {
        Navigator.of(context).removeRoute(dialogRoute!);
        dialogRoute = null;
      }
    } catch (_) {}
  }

  Future<void> showConfirmDialog({
    required BuildContext context,
    String label = "Are you sure?",
    String yesLabel = "Confirm",
    String noLabel = "Cancel",
    Function()? onClickYes,
    Function()? onClickNo,
    Color yesBg = AppColors.primary
  }) async {

    if (dialogRoute != null) {
      dismissDialog(context: context);
    }

    dialogRoute = DialogRoute(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.bg1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.basePaddingL,
                vertical: AppConstants.basePaddingL
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: AppConstants.baseFontSizeL,
                      color: AppColors.text1,
                      fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: AppConstants.baseButtonHeightMS,
                        child: ElevatedButton(
                          onPressed: () {
                            if (onClickNo != null) onClickNo();
                            dismissDialog(context: context);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.textFieldBg
                          ),
                          child: Text(
                            noLabel,
                            style: const TextStyle(
                                fontSize: AppConstants.baseFontSizeM,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text1
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: AppConstants.baseButtonHeightMS,
                        child: ElevatedButton(
                          onPressed: () {
                            if (onClickYes != null) onClickYes();
                            dismissDialog(context: context);
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: yesBg
                          ),
                          child: Text(
                            yesLabel,
                            style: const TextStyle(
                                fontSize: AppConstants.baseFontSizeM,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryOver
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    Navigator.of(context).push(dialogRoute!);
  }


  Future<void> showLoadingDialog({
    required BuildContext context,
  }) async {
    if (dialogRoute != null) {
      dismissDialog(context: context);
    }

    dialogRoute = DialogRoute(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.basePaddingL,
                vertical: AppConstants.basePaddingL
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          ),
        );
      },
    );
    Navigator.of(context).push(dialogRoute!);
  }

}
