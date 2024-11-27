part of '../super_select.dart';

class SuperSelectListItem extends StatefulWidget {
  final BuildContext context;
  final SuperSelectController controller;
  final ItemData itemData;
  final TextStyle? textStyle;
  final bool multiSelect;

  const SuperSelectListItem({
    super.key,
    required this.context,
    required this.controller,
    required this.itemData,
    this.textStyle,
    this.multiSelect = false,
  });

  @override
  State<StatefulWidget> createState() => _SuperSelectListItemState();
}

class _SuperSelectListItemState extends State<SuperSelectListItem> {
  bool _checked = false;
  late double textWidth;

  Widget get single {
    return InkWell(
      onTap: () {
        widget.controller._setItem(widget.itemData);
        Navigator.pop(widget.context);
      },
      child: SizedBox(
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                children: [
                  Text(widget.itemData.text,
                    style: (widget.textStyle != null)
                        ? widget.textStyle
                        : Theme.of(widget.context).textTheme.titleMedium,
                  )
                ],
              ),
          )
      ),
    );
  }

  Widget get multi {
    _checked = widget.controller._selectedItems.contains(widget.itemData);
    return InkWell(
      onTap: () {
        setState(() {
          _checked = !_checked;
        });

        if (_checked) {
          widget.controller._addItem(widget.itemData);
        } else {
          widget.controller._removeItem(widget.itemData);
        }
      },
      child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: textWidth,
                  child: Text(widget.itemData.text,
                    style: (widget.textStyle != null)
                        ? widget.textStyle
                        : Theme.of(widget.context).textTheme.titleMedium,
                  ),
                ),
                Checkbox(
                    value: _checked,
                    onChanged: null,
                )
              ],
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    textWidth = MediaQuery.of(context).size.width * 0.85;
    if (widget.multiSelect) {
      return multi;
    } else {
      return single;
    }
  }
  
}