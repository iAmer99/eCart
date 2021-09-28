import 'package:ecart/features/checkout/controller/checkout_controller.dart';
import 'package:ecart/features/shared/widgets/myTextFormField.dart';
import 'package:ecart/features/checkout/widgets/page_indicator.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressForm extends GetView<CheckoutController> {
  AddressForm({Key? key, required this.formKey}) : super(key: key);
  final GlobalKey<FormState> formKey;
  static final TextEditingController _addressController =
      TextEditingController();
  static final FocusNode _addressNode = FocusNode();
  static final TextEditingController _cityController = TextEditingController();
  static final FocusNode _cityNode = FocusNode();
  static final TextEditingController _countryController =
      TextEditingController();
  static final FocusNode _countryNode = FocusNode();
  static final TextEditingController _postalCodeController =
      TextEditingController();
  static final FocusNode _postalCodeNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            "shipping_address".tr,
            style: TextStyle(
              color: Get.theme.primaryColorDark.withOpacity(0.8),
              fontSize: 3.6 * textMultiplier,
            ),
          ),
          SizedBox(
            height: 2 * heightMultiplier,
          ),
          PageIndicator(index: 0),
          SizedBox(
            height: 3 * heightMultiplier,
          ),
          MyTextFormField(
            controller: _addressController,
            node: _addressNode,
            nextNode: _cityNode,
            label: "address".tr,
            icon: Icon(Icons.home),
            validator: (String? address) {
              if (address == null || address.trim().isEmpty) {
                return "address_hint".tr;
              } else {
                return null;
              }
            },
          ),
          MyTextFormField(
            controller: _cityController,
            node: _cityNode,
            nextNode: _countryNode,
            label: "city".tr,
            icon: Icon(Icons.location_city),
            validator: (String? city) {
              if (city == null || city.trim().isEmpty) {
                return "city_hint".tr;
              } else {
                return null;
              }
            },
          ),
          MyTextFormField(
            controller: _countryController,
            node: _countryNode,
            nextNode: _postalCodeNode,
            label: "country".tr,
            icon: Icon(Icons.map_outlined),
            validator: (String? country) {
              if (country == null || country.trim().isEmpty) {
                return "country_hint".tr;
              } else {
                return null;
              }
            },
          ),
          MyTextFormField(
            controller: _postalCodeController,
            node: _postalCodeNode,
            label: "postal_code".tr,
            onComplete: () {
              closeKeyboard(context);
              if (formKey.currentState!.validate()) {
                controller.updateAddressData(
                  address: _addressController.text.trim(),
                  city: _cityController.text.trim(),
                  country: _countryController.text.trim(),
                  code: _postalCodeController.text.trim(),
                );
              }
            },
            icon: Icon(Icons.markunread_mailbox_outlined),
            validator: (String? code) {
              if (code == null || code.trim().isEmpty) {
                return "postal_code_hint".tr;
              } else {
                return null;
              }
            },
          ),
          Container(
              width: 75 * widthMultiplier,
              height: 8 * heightMultiplier,
              child: ElevatedButton(
                  onPressed: () {
                    closeKeyboard(context);
                    if (formKey.currentState!.validate()) {
                      controller.updateAddressData(
                        address: _addressController.text.trim(),
                        city: _cityController.text.trim(),
                        country: _countryController.text.trim(),
                        code: _postalCodeController.text.trim(),
                      );
                    }
                  },
                  child: Text(
                    "continue".tr,
                    style: TextStyle(fontSize: 3.6 * textMultiplier),
                  ))),
        ],
      ),
    );
  }
}
