import 'package:ecart/features/checkout/controller/checkout_controller.dart';
import 'package:ecart/features/checkout/widgets/address_form.dart';
import 'package:ecart/features/checkout/widgets/payment_form.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> _paymentFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (controller){
        return ModalProgressHUD(
          inAsyncCall: controller.status.isLoading,
          child: GestureDetector(
            onTap: (){
              closeKeyboard(context);
            },
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.4 * Get.statusBarHeight,
                        ),
                        MyAppBar(
                          title: Text(
                            "checkout".tr,
                            style: TextStyle(
                              color: Get.theme.primaryColorDark,
                              fontSize: 2.5 * textMultiplier,
                            ),
                          ),
                          hideCart: true,
                        ),
                        SizedBox(
                          height: 2 * heightMultiplier,
                        ),
                        ObxValue<RxInt>(
                              (index) => IndexedStack(
                            index: index.value,
                            children: [
                              AddressForm(formKey: _addressFormKey),
                              PaymentForm(formKey: _paymentFormKey)
                            ],
                          ),
                          controller.index,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
