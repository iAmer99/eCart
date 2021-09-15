import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/checkout/repository/checkout_repository.dart';
import 'package:ecart/routes/routes_names.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final CheckoutRepository _repository;

  CheckoutController(this._repository);

  RxInt index = 0.obs;
  RxStatus _status = RxStatus.empty();
  RxStatus get status => _status;

  String _address = "";
  String _city = "";
  String _country = "";
  String _postalCode = "";
  String _phoneNumber = "";
  String _cvc = "";
  String _month = "";
  String _year = "";
  String _cardNumbers = "";

  updateAddressData({
    required String address,
    required String city,
    required String country,
    required String code,
  }) {
    _address = address;
    _city = city;
    _country = country;
    _postalCode = code;
    index++;
  }

  updatePaymentInfo({
    required String phone,
    required String cvc,
    required String cardNumbers,
    required String year,
    required String month,
  }) {
    _phoneNumber = phone;
    _cvc = cvc;
    _cardNumbers = cardNumbers;
    _year = year;
    if (month.length > 1) {
      _month = month;
    } else {
      _month = "0" + month;
    }
  }

  createOrder() async {
    _status = RxStatus.loading();
    update();
    Map<String, Object> data = {
      "shippingAddress": {
        "address": _address,
        "city": _city,
        "country": _country,
        "postalCode": _postalCode,
      },
      "paymentMethod": "card",
      "phone": _phoneNumber,
      "cardNumber": _cardNumbers,
      "expMonth": _month,
      "expYear": _year,
      "cvc": _cvc,
    };
    final response = await _repository.createOrder(data);
    response.fold((error) {
      _status = RxStatus.error();
      update();
      showErrorDialog(error);
    }, (msg) {
      _status = RxStatus.success();
      update();
      showSuccessDialog(
        msg,
        onAction: () {
          SessionManagement.resetDiscount();
          Get.offAllNamed(AppRoutesNames.bottomBarScreen);
        },
      );
    });
  }

  goBack() {
    index--;
  }
}
