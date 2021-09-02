import 'package:ecart/features/favourites/repository/favourite_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  final FavouritesRepository _repository;

  FavouritesController(this._repository);

  List<Product> favourites = [];
  RxStatus _status = RxStatus.loading();

  RxStatus get status => _status;

  getFavourites() async {
    _status = RxStatus.loading();
    update();
    final response = await _repository.getFavourites();
    response.fold((error) {
      _status = RxStatus.error(error);
      update();
    }, (favourites) {
      this.favourites = favourites;
      if (favourites.isEmpty) {
        _status = RxStatus.empty();
        update();
      } else {
        _status = RxStatus.success();
        update();
      }
    });
  }

  removeFromFavourites(String id) async {
    final response = await _repository.removeFromFavourites(id);
    response.fold((error) {
      showSnackBar(error);
    }, (res) {
      if (res) {
        getFavourites();
      } else {
        showSnackBar("Something went wrong!");
      }
    });
  }

  @override
  void onInit() {
    getFavourites();
    super.onInit();
  }
}
