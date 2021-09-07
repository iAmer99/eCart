import 'package:ecart/features/favourites/repository/favourite_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  final FavouritesRepository _repository;

  FavouritesController(this._repository);

  List<Product> favourites = [];
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
     if(favourites.isNotEmpty){
       this.favourites = favourites;
       _status = RxStatus.success();
       update();
     }else{
       _status = RxStatus.empty();
       update();
     }
      } );
  }


  removeFromFavourites(String id) async {
    Product removedProduct = favourites.firstWhere((element) => element.id == id);
    int index = favourites.indexOf(removedProduct);
    favourites.removeAt(index);
    update();
    final response = await _repository.removeFromFavourites(id);
    response.fold((error) {
      favourites.insert(index, removedProduct);
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        favourites.insert(index, removedProduct);
        update();
        showSnackBar("Something went wrong!");
      }
    });
    if(favourites.isEmpty){
      _status = RxStatus.empty();
      update();
    }
  }


  @override
  void onInit() {
    getFavourites();
    super.onInit();
  }
}
