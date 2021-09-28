import 'package:ecart/features/auth/validators.dart';
import 'package:ecart/features/checkout/controller/checkout_controller.dart';
import 'package:ecart/features/shared/widgets/myTextFormField.dart';
import 'package:ecart/features/checkout/widgets/page_indicator.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentForm extends GetView<CheckoutController> {
  PaymentForm({Key? key, required this.formKey}) : super(key: key);
  final GlobalKey<FormState> formKey;
  static final TextEditingController _phoneController = TextEditingController();
  static final FocusNode _phoneNode = FocusNode();
  static final TextEditingController _cardNumbersController =
      TextEditingController();
  static final FocusNode _cardNumbersNode = FocusNode();
  static final TextEditingController _monthController = TextEditingController();
  static final FocusNode _monthNode = FocusNode();
  static final TextEditingController _yearController = TextEditingController();
  static final FocusNode _yearNode = FocusNode();
  static final TextEditingController _cvcController = TextEditingController();
  static final FocusNode _cvcNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            "payment".tr,
            style: TextStyle(
              color: Get.theme.primaryColorDark.withOpacity(0.8),
              fontSize: 3.6 * textMultiplier,
            ),
          ),
          SizedBox(
            height: 2 * heightMultiplier,
          ),
          PageIndicator(index: 1),
          SizedBox(
            height: 3 * heightMultiplier,
          ),
          MyTextFormField(
            controller: _phoneController,
            node: _phoneNode,
            nextNode: _cardNumbersNode,
            keyboardType: TextInputType.phone,
            label: "phone".tr,
            icon: Icon(Icons.phone),
            validator: (String? phone) => isValidPhone(phone),
          ),
          MyTextFormField(
            controller: _cardNumbersController,
            node: _cardNumbersNode,
            nextNode: _monthNode,
            keyboardType: TextInputType.number,
            label: "card_numbers".tr,
            icon: Icon(Icons.credit_card_rounded),
            validator: (String? card) {
              if (card == null || card.isEmpty) {
                return "wrong_card".tr;
              } else if (card.trim().length != 16) {
                return "wrong_card".tr;
              } else {
                return null;
              }
            },
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "expiry_date".tr,
              style: TextStyle(
                color: Get.theme.primaryColorDark.withOpacity(0.7),
                fontSize: 2 * textMultiplier,
              ),
            ),
          ),
          SizedBox(
            height: heightMultiplier,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MyTextFormField(
                  controller: _monthController,
                  node: _monthNode,
                  nextNode: _yearNode,
                  keyboardType: TextInputType.number,
                  label: "month".tr,
                ),
              ),
              SizedBox(
                width: widthMultiplier,
              ),
              Expanded(
                flex: 1,
                child: MyTextFormField(
                  controller: _yearController,
                  node: _yearNode,
                  nextNode: _cvcNode,
                  keyboardType: TextInputType.number,
                  label: "year".tr,
                ),
              ),
              SizedBox(
                width: widthMultiplier,
              ),
              Expanded(
                flex: 1,
                child: MyTextFormField(
                  controller: _cvcController,
                  node: _cvcNode,
                  keyboardType: TextInputType.number,
                  onComplete: () {
                    closeKeyboard(context);
                    if (formKey.currentState!.validate()) {
                      if (_monthController.text.trim().isEmpty ||
                          _yearController.text.trim().isEmpty) {
                        showSnackBar(
                            "Please enter your card expiry date");
                      } else if (_monthController.text.trim().isEmpty ||
                          _yearController.text.trim().isEmpty &&
                              _cvcController.text.trim().isEmpty) {
                        showSnackBar(
                            "Please enter your card expiry date & cvc");
                      } else if (_cvcController.text.trim().isEmpty) {
                        showSnackBar("Please enter your card cvc");
                      } else if (_monthController.text.trim().length >
                          2 ||
                          _yearController.text.trim().length != 4) {
                        showSnackBar("Please enter correct expiry date");
                      } else {
                        controller.updatePaymentInfo(
                          phone: _phoneController.text.trim(),
                          cvc: _cvcController.text.trim(),
                          cardNumbers: _cardNumbersController.text.trim(),
                          year: _yearController.text.trim(),
                          month: _monthController.text.trim(),
                        );
                        controller.createOrder();
                      }
                    }
                  },
                  label: "CVC",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    height: 8 * heightMultiplier,
                    child: ElevatedButton(
                        onPressed: () {
                          closeKeyboard(context);
                          controller.goBack();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                        ),
                        child: Text(
                          "previous".tr,
                          style: TextStyle(fontSize: 3.6 * textMultiplier),
                        ))),
              ),
              SizedBox(
                width: 3 * widthMultiplier,
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: 8 * heightMultiplier,
                    child: ElevatedButton(
                        onPressed: () {
                          closeKeyboard(context);
                          if (formKey.currentState!.validate()) {
                            if (_monthController.text.trim().isEmpty ||
                                _yearController.text.trim().isEmpty) {
                              showSnackBar(
                                  "Please enter your card expiry date");
                            } else if (_monthController.text.trim().isEmpty ||
                                _yearController.text.trim().isEmpty &&
                                    _cvcController.text.trim().isEmpty) {
                              showSnackBar(
                                  "Please enter your card expiry date & cvc");
                            } else if (_cvcController.text.trim().isEmpty) {
                              showSnackBar("Please enter your card cvc");
                            } else if (_monthController.text.trim().length >
                                    2 ||
                                _yearController.text.trim().length != 4) {
                              showSnackBar("Please enter correct expiry date");
                            } else {
                              controller.updatePaymentInfo(
                                phone: _phoneController.text.trim(),
                                cvc: _cvcController.text.trim(),
                                cardNumbers: _cardNumbersController.text.trim(),
                                year: _yearController.text.trim(),
                                month: _monthController.text.trim(),
                              );
                              controller.createOrder();
                            }
                          }
                        },
                        child: Text(
                          "pay".tr,
                          style: TextStyle(fontSize: 3.6 * textMultiplier),
                        ))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
