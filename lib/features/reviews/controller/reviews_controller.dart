import 'package:ecart/features/reviews/repository/models/reviews_response.dart';
import 'package:ecart/features/reviews/repository/reviews_repository.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:get/get.dart';

class ReviewsController extends GetxController {
  final ReviewsRepository _repository;

  ReviewsController(this._repository);

  Product product = Get.arguments;
  List<Map<String, Object>> reviewsData = [];
  int pagePagination = 1;
  bool lastPage = false;

  RxStatus _status = RxStatus.loading();

  RxStatus get status => _status;

  RxDouble rating = 0.0.obs;

  RxStatus _editorStatus = RxStatus.empty();

  RxStatus get editorStatus => _editorStatus;

  getEditData(Review review) {
    rating = review.rating!.toDouble().obs;
  }

  updateRating(double rating) {
    this.rating.value = rating;
  }

  getReviews() async {
    if (!_status.isLoadingMore) {
      if (reviewsData.isNotEmpty) {
        _status = RxStatus.loadingMore();
        update();
      } else {
        _status = RxStatus.loading();
        pagePagination = 1;
        update();
      }
      final response =
          await _repository.getReviews(product.id!, pagePagination);
      response.fold((error) {
        _status = RxStatus.error(error);
        update();
      }, (data) {
        if (data.isEmpty) {
          if (reviewsData.isEmpty) {
            _status = RxStatus.empty();
            lastPage = true;
            update();
          } else {
            _status = RxStatus.success();
            lastPage = true;
            update();
          }
        } else {
          if (reviewsData.isEmpty) {
            reviewsData = data;
            _status = RxStatus.success();
            update();
          } else {
            this.reviewsData.addAll(data.where(
                (comingReview) => this.reviewsData.every((existingReview) {
                      Review review1 = comingReview['review'] as Review;
                      Review review2 = existingReview['review'] as Review;
                      return review1.review != review2.review &&
                          review1.id != review2.id;
                    })));
            _status = RxStatus.success();
            update();
          }
        }
      });
    }
  }

  refreshProduct() async {
    _status = RxStatus.loading();
    update();
    final response = await _repository.refreshProduct(product.id!);
    response.fold((error) {
      update();
      showSnackBar(error);
    }, (product) {
      this.product = product;
      update();
    });
  }

  loadNextPage() {
    if (!lastPage && !_status.isLoading && !_status.isLoadingMore) {
      pagePagination++;
    }
  }

  deleteReview(String reviewID) async {
    Map<String, Object> removedReview = reviewsData.firstWhere((map) {
      Review review = map["review"] as Review;
      return review.id == reviewID;
    });
    int index = reviewsData.indexOf(removedReview);
    reviewsData.removeAt(index);
    update();
    if (reviewsData.isEmpty) {
      _status = RxStatus.empty();
      update();
    }
    final response = await _repository.deleteReview(product.id!, reviewID);
    response.fold((error) {
      reviewsData.insert(index, removedReview);
      update();
      showSnackBar(error);
    }, (res) {
      if (!res) {
        reviewsData.insert(index, removedReview);
        update();
        showSnackBar("Something went wrong!");
      }
    });
    await refreshProduct();
    await getReviews();
  }

  addReview(String review) async {
    _editorStatus = RxStatus.loading();
    update();
    final response = await _repository.addReview(product.id!, {
      "review": review,
      "rating": rating.value,
    });
    response.fold((error) {
      _editorStatus = RxStatus.error();
      update();
      showErrorDialog(error);
    }, (res) async {
      if (!res) {
        _editorStatus = RxStatus.error();
        update();
        showErrorDialog("Something went wrong!");
      } else {
        await refreshProduct();
        await getReviews();
        _editorStatus = RxStatus.success();
        update();
        Get.back();
      }
    });
  }

  editReview(String review, String reviewID) async {
    _editorStatus = RxStatus.loading();
    update();
    Map<String, Object> selectedReview = reviewsData.firstWhere((element) {
      Review review = element["review"] as Review;
      return review.id == reviewID;
    });
    final response = await _repository.editReview(product.id!, reviewID, {
      "review": review,
      "rating": rating.value,
    });
    response.fold((error) {
      _editorStatus = RxStatus.error();
      update();
      showErrorDialog(error);
    }, (res) async {
      if (!res) {
        _editorStatus = RxStatus.error();
        update();
        showErrorDialog("Something went wrong!");
      } else {
        Review editedReview = selectedReview["review"] as Review;
        editedReview.reviewSetter = review;
        editedReview.ratingSetter = rating.value;
        await refreshProduct();
        await getReviews();
        _editorStatus = RxStatus.success();
        update();
        Get.back();
      }
    });
  }

  @override
  void onInit() async {
    await refreshProduct();
    getReviews();
    super.onInit();
  }
}
