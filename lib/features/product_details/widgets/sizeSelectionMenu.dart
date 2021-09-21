import 'package:ecart/features/product_details/controller/product_controller.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeSelectionMenu extends StatefulWidget {
  const SizeSelectionMenu({Key? key, required this.data}) : super(key: key);
  final List<Size> data;

  @override
  _SizeSelectionMenuState createState() => _SizeSelectionMenuState();
}

class _SizeSelectionMenuState extends State<SizeSelectionMenu> {
 late Size _size;
  final ProductController _controller = Get.find<ProductController>();
  @override
  void initState() {
    super.initState();
    _size = widget.data.first;
    if(!_controller.status.isLoading){
      _size = _controller.selectedSize;
    }
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        value: _size.id,
        items: [
          ...(widget.data.map((item){
            return DropdownMenuItem<String>(child: Text(
              item.size!,
              style: TextStyle(
                fontSize: 2.2 * textMultiplier,
              ),
            ),
              value: item.id,
            );
          }).toList())
        ],
        onChanged: (value){
          setState(() {
            _size = widget.data.firstWhere((element) => element.id == value);
          });
          _controller.selectSize(_size);
        },
      ),
    );
  }
}
