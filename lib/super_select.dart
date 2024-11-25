library super_select;

import 'package:flutter/material.dart';

part 'shared/super_select_controller.dart';
part 'shared/super_select_shared.dart';
part 'widget/super_select_dialog.dart';
part 'widget/super_select_list_item.dart';

class SuperSelect extends StatefulWidget {
  final BuildContext context;
  final List<ItemData> items;
  final SuperSelectController controller;
  final ItemsValueType itemsValueType;
  final void Function()? onTap;
  final bool multiSelect;
  final DialogMode dialogMode;
  final Widget? title;
  final TextStyle? itemTextStyle;
  final String? Function(String?)? validator;

  const SuperSelect({super.key,
    required this.context,
    required this.items,
    required this.controller,
    this.validator,
    this.itemsValueType = ItemsValueType.int, // default int value type
    this.onTap,
    this.multiSelect = false, // default not multi select
    this.dialogMode = DialogMode.bottomSheet,
    this.title,
    this.itemTextStyle
  });

  @override
  State<StatefulWidget> createState() => SuperSelectState();
}

class SuperSelectState extends State<SuperSelect> {
  final TextEditingController _textEditingController = TextEditingController();
  ItemData? lastItemData;
  bool gotFocus = false;
  bool dropdownIsVisible = false;
  final FocusNode focusNode = FocusNode();

  void updateText() {
    debugPrint("SUPER SELECT UPDATE DISPLAY.");
    setState(() {
      if (widget.multiSelect) {
        List<ItemData> itemDataList = widget.controller.result;
        if (itemDataList.isNotEmpty) {
          for(ItemData itemData in itemDataList) {
            debugPrint("MULTI CHOICE SELECTED ARE: ${itemData.value} (${itemData.text})");
          }
          _textEditingController.text = "${itemDataList.length} Selected";
        } else {
          _textEditingController.clear();
          debugPrint("MULTI CHOICE SELECTED ARE: NONE SELECTED");
        }
      } else {
        ItemData? itemData = widget.controller.result;
        if (itemData != null) {
          debugPrint("SINGLE CHOICE IS: ${itemData.value} (${itemData.text})");
          _textEditingController.text = itemData.text;
        } else {
          debugPrint("SINGLE CHOICE IS: NONE SELECTED ");
          _textEditingController.clear();
        }
      }
    });
  }

  void _defaultOnTapAction() async {
    debugPrint("DEFAULT DIALOG OPENED, WAITING CHOICE");

    switch(widget.dialogMode) {
      case DialogMode.dialog:
        dropdownIsVisible = true;
        await SuperSelectDialog.dialog(
          context: context,
          controller: widget.controller,
          items: widget.items,
          title: widget.title,
          itemTextStyle: widget.itemTextStyle,
          multiSelect: widget.multiSelect,
        );
        dropdownIsVisible = false;
        break;
      case DialogMode.bottomSheet:
      default:
        dropdownIsVisible = true;
        await SuperSelectDialog.bottomSheet(
          context: context,
          controller: widget.controller,
          items: widget.items,
          title: widget.title,
          itemTextStyle: widget.itemTextStyle,
          multiSelect: widget.multiSelect,
          lastItemData: lastItemData,
        );
        dropdownIsVisible = false;
    }
    updateText();
  }

  void handleOnTap() {
    widget.onTap ?? _defaultOnTapAction();
  }

  @override
  void initState() {
    widget.controller.addListener(updateText);
    widget.controller._multiSelect = widget.multiSelect;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          if(!gotFocus) {
            gotFocus = true;
            focusNode.requestFocus();
            if (!dropdownIsVisible && widget.controller.result == null) {
              handleOnTap();
            }
          }
        } else {
          if (!dropdownIsVisible) gotFocus = false;
        }
      },
      child: Column(
        children: [
          TextFormField(
              controller: _textEditingController,
              focusNode: focusNode,
              readOnly: true,
              onTap: handleOnTap,
              onEditingComplete: () {},
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down)
              ),
              validator: widget.validator
          ),
          // can add on widget to display selected values and to delete from there
          // if (widget.multiSelect) Text('multi select'),
        ],
      ),
    );
  }
}