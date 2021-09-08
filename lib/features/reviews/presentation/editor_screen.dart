import 'package:ecart/features/reviews/controller/reviews_controller.dart';
import 'package:ecart/features/reviews/modes.dart';
import 'package:ecart/features/reviews/repository/models/reviews_response.dart';
import 'package:ecart/features/shared/widgets/appBar.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditorReview extends StatefulWidget {
  EditorReview({Key? key, this.review}) : super(key: key);
  final Review? review;

  @override
  _EditorReviewState createState() => _EditorReviewState();
}

class _EditorReviewState extends State<EditorReview> {
  final Mode mode = Get.arguments;
  ReviewsController _controller = Get.find<ReviewsController>();
  final TextEditingController _reviewController = TextEditingController();
  final FocusNode _node = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.updateRating(0);
    if (widget.review != null) {
      _controller.getEditData(widget.review!);
      _reviewController.text = widget.review!.review!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsController>(
      builder: (_) {
        return ModalProgressHUD(
          inAsyncCall: _controller.editorStatus.isLoading,
          child: GestureDetector(
            onTap: () {
              closeKeyboard(context);
            },
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4 * widthMultiplier),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.statusBarHeight * 0.4,
                        ),
                        MyAppBar(
                          title: Text(
                            mode == Mode.Edit ? "Edit" : "Write a review",
                            style: TextStyle(
                              color: Get.theme.primaryColorDark,
                              fontSize: 2.2 * textMultiplier,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4 * heightMultiplier,
                        ),
                        Obx(() => Text(
                              "${_controller.rating.value}",
                              style: TextStyle(
                                color: Get.theme.primaryColorDark,
                                fontSize: 3.6 * textMultiplier,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        SizedBox(
                          height: heightMultiplier,
                        ),
                        RatingBar.builder(
                          initialRating: mode == Mode.Edit
                              ? widget.review!.rating!.toDouble()
                              : 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          updateOnDrag: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Get.theme.primaryColor,
                          ),
                          onRatingUpdate: (rating) {
                            _controller.updateRating(rating);
                          },
                        ),
                        SizedBox(
                          height: 3 * heightMultiplier,
                        ),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _reviewController,
                            focusNode: _node,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Get.theme.primaryColor),
                                borderRadius: BorderRadius.circular(
                                    1.5 * heightMultiplier),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Get.theme.primaryColor),
                                borderRadius: BorderRadius.circular(
                                    1.5 * heightMultiplier),
                              ),
                              hintText: "Enter your review",
                              hintStyle: TextStyle(
                                  color: Get.theme.primaryColorDark
                                      .withOpacity(0.5)),
                              helperStyle:
                                  TextStyle(color: Get.theme.primaryColor),
                            ),
                            maxLines: 6,
                            maxLength: 400,
                            keyboardType: TextInputType.multiline,
                            validator: (String? value) {
                              if (value == null) {
                                return "Enter your review";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3 * heightMultiplier,
                        ),
                        Container(
                          height: 8 * heightMultiplier,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 4 * widthMultiplier,
                              vertical: heightMultiplier),
                          child: ElevatedButton(
                            onPressed: () {
                              closeKeyboard(context);
                              if (_formKey.currentState!.validate()) {
                                if (mode == Mode.Write) {
                                  _controller
                                      .addReview(_reviewController.text.trim());
                                } else {
                                  _controller.editReview(
                                      _reviewController.text.trim(),
                                      widget.review!.id!);
                                }
                              }
                            },
                            child: Text(
                              mode == Mode.Write ? "Add Review" : "Edit",
                              style: TextStyle(fontSize: 3.6 * textMultiplier),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
