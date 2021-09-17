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
            "Payment",
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
            label: "Phone Number",
            icon: Icon(Icons.phone),
            validator: (String? phone) => isValidPhone(phone),
          ),
          MyTextFormField(
            controller: _cardNumbersController,
            node: _cardNumbersNode,
            nextNode: _monthNode,
            keyboardType: TextInputType.number,
            label: "Card Numbers",
            icon: Icon(Icons.credit_card_rounded),
            validator: (String? card) {
              if (card == null || card.isEmpty) {
                return "Please enter your credit card numbers";
              } else if (card.trim().length != 16) {
                return "Please enter correct credit card numbers";
              } else {
                return null;
              }
            },
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Expiry Date",
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
                  label: "Month",
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
                  label: "Year",
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
                          "Previous",
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
                          "Pay Now",
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
