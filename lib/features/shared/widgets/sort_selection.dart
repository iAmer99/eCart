import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:get/get.dart';

class SortSelection extends StatefulWidget {
   SortSelection({Key? key, required this.onSelection}) : super(key: key);
   final Function(int selection) onSelection;

  @override
  _SortSelectionState createState() => _SortSelectionState();
}

class _SortSelectionState extends State<SortSelection> {
  int _tag = 0;

  List<String> _options = [
    'Popular', 'Alphabetically', 'Price: High to Low',
    'Price: Low to High'];

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
      value: _tag,
      choiceStyle: C2ChoiceStyle(
        borderColor: Get.theme.primaryColorDark,
        color: Get.theme.primaryColorDark,
      ),
      choiceActiveStyle: C2ChoiceStyle(
        borderColor: Get.theme.primaryColor,
        color: Get.theme.primaryColor,
      ),
      onChanged: (val){
        setState(() => _tag = val);
        widget.onSelection(val);
      },
      choiceItems: C2Choice.listFrom<int, String>(
        source: _options,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
    );
  }
}
