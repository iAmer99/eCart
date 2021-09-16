import 'package:ecart/features/update_account/repository/account_repository.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  final AccountRepository _repository;

  AccountController(this._repository);
}