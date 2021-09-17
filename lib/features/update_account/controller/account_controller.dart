import 'dart:io';

import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/update_account/repository/account_repository.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class AccountController extends GetxController {
  final AccountRepository _repository;

  AccountController(this._repository);

  RxStatus _status = RxStatus.empty();

  RxStatus get status => _status;
  Rx<File> image = File('').obs;
  dio.MultipartFile? imageData;
  String? imageUpdateError;

  pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      this.image.value = File(image.path);
    }
  }

  updateData(
      {String? name, String? email, String? address, String? phone}) async {
    _status = RxStatus.loading();
    update();
    if (image.value.path.isNotEmpty) {
      imageData = await dio.MultipartFile.fromFile(image.value.path,
          contentType: new MediaType("image", "jpg"));
      dio.FormData formData = dio.FormData.fromMap({"image": imageData});
      final res = await _repository.updatePicture(formData);
      res.fold((error) {
        imageUpdateError = error;
      }, (_response) {
        if (!_response) {
          imageUpdateError = "Something went wrong!";
        }
      });
    }
    Map<String, Object> data = {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (address != null) "address": address,
      if (phone != null) "phone": phone,
    };
    final response = await _repository.updateData(data);
    response.fold(
      (error) {
        _status = RxStatus.error();
        update();
        String errorMsg =
            imageUpdateError != null ? "$error , $imageUpdateError" : error;
        showErrorDialog(errorMsg);
      },
      (user) {
        if(imageUpdateError == null){
          SessionManagement.updateUserData(
            name: user.name,
            phone: user.phone,
            address: user.address,
            email: user.email,
            imageUrl: user.profileImage,
          );
          _status = RxStatus.success();
          update();
          Get.back();
        }else{
          _status = RxStatus.error();
          update();
          showErrorDialog(imageUpdateError!);
        }
      },
    );
  }
}
