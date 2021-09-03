import 'package:ecart/features/favourites/repository/favourite_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  final FavouritesRepository _repository;

  FavouritesController(this._repository);

  List<Product> favourites = [];
  List<String> favIDs = [];
  RxStatus _status = RxStatus.loading();

  RxStatus get status => _status;


  getFavourites() async {
    favourites = [];
    _status = RxStatus.loading();
    update();
    final response = await _repository.getFavourites();
    response.fold((error) {
      _status = RxStatus.error(error);
      update();
    }, (favourites) async {
        if (favourites.isEmpty) {
          _status = RxStatus.empty();
          update();
        } else {
          favIDs = favourites;
          bool isDone = await getFavouritesData();
          if (isDone) {
            _status = RxStatus.success();
            update();
          } else {
            _status = RxStatus.error("Something went wrong!");
            update();
          }
        }
      } );
  }

  Future<bool> getFavouritesData() async {
    favIDs.forEach((id) async {
      final response = await _repository.getProduct(id);
      response.fold((error) {
        return false;
      }, (product) {
          this.favourites.add(product);
          update();
      });
    });
    return true;
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
