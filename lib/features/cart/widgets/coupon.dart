import 'package:ecart/core/session_management.dart';
import 'package:ecart/features/auth/validators.dart';
import 'package:ecart/features/cart/controller/cart_controller.dart';
import 'package:ecart/utils/helper_functions.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponRow extends StatefulWidget {
  const CouponRow({Key? key, required this.couponController, required this.node,}) : super(key: key);
  final TextEditingController couponController;
  final FocusNode node;

  @override
  _CouponRowState createState() => _CouponRowState();
}

class _CouponRowState extends State<CouponRow> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_controller) {
        widget.couponController.text = _controller.code;
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coupon Code",
                style: TextStyle(
                  color: Get.theme.primaryColorDark.withOpacity(0.7),
                  fontSize: 2 * textMultiplier,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IgnorePointer(
                    ignoring: SessionManagement.discountCode != null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.theme.accentColor,
                        borderRadius:
                            BorderRadius.circular(1.5 * heightMultiplier),
                      ),
                      width: 50 * widthMultiplier,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2 * widthMultiplier),
                      margin: EdgeInsets.only(top: heightMultiplier),
                      child: TextFormField(
                        controller: widget.couponController,
                        focusNode: widget.node,
                        onChanged: (String value)=> _controller.onCodeChange(value),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 1 * textMultiplier,
                              vertical: 1.5 * textMultiplier),
                          border: InputBorder.none,
                        ),
                        validator: (String? value) => isValidCode(value),
                      ),
                    ),
                  ),
                  if (SessionManagement.discountCode != null)
                    IconButton(
                        onPressed: () {
                          _controller.deleteDiscount();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        )),
                  Expanded(
                    child: IgnorePointer(
                      ignoring: SessionManagement.discountCode != null,
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: _controller.discountStatus.isLoading
                            ? Padding(
                                padding: EdgeInsetsDirectional.only(
                                    end: 3 * widthMultiplier),
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                height: 6 * heightMultiplier,
                                child: ElevatedButton(
                                  onPressed: () {
                                    closeKeyboard(context);
                                    if (widget.couponController.text
                                        .trim()
                                        .isNotEmpty) {
                                      _controller.verifyDiscount(
                                          widget.couponController.text.trim());
                                    } else {
                                      showSnackBar("Enter coupon code");
                                    }
                                  },
                                  child: Text(
                                    SessionManagement.discountCode == null
                                        ? "Verify"
                                        : "Verified",
                                    style: TextStyle(
                                      fontSize: 2.2 * textMultiplier,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        SessionManagement.discountCode == null
                                            ? Get.theme.primaryColor
                                            : Colors.grey),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: heightMultiplier,
              ),
              if (SessionManagement.discountCode != null)
                Text(
                  "Your order will be ${SessionManagement.discount}% off",
                  style: TextStyle(
                    color: Get.theme.primaryColorDark.withOpacity(0.7),
                    fontSize: 2.2 * textMultiplier,
                  ),
                ),
              if (_controller.discountStatus.isError)
                Text(
                  _controller.discountStatus.errorMessage!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 2 * textMultiplier,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
