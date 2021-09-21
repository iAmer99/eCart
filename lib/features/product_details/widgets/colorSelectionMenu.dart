import 'package:ecart/features/product_details/controller/product_controller.dart';
import 'package:ecart/features/shared/models/product.dart';
import 'package:ecart/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorSelectionMenu extends StatefulWidget {
  const ColorSelectionMenu({Key? key, required this.data}) : super(key: key);
  final List<Color> data;

  @override
  _ColorSelectionMenuState createState() => _ColorSelectionMenuState();
}

class _ColorSelectionMenuState extends State<ColorSelectionMenu> {
 late Color _color;
  final ProductController _controller = Get.find<ProductController>();
  @override
  void initState() {
    super.initState();
    _color = widget.data.first;
    if(!_controller.status.isLoading){
      _color = _controller.selectedColor;
    }
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        value: _color.id,
        items: [
          ...(widget.data.map((item){
            return DropdownMenuItem<String>(child: Text(
              item.color!,
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
            _color = widget.data.firstWhere((element) => element.id == value);
          });
          _controller.selectColor(_color);
        },
      ),
    );
  }
}
