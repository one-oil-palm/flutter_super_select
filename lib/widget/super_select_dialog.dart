part of '../super_select.dart';

class SuperSelectDialog {
  /*final BuildContext context;
  final DialogMode dialogMode;
  final bool multiSelect;

  const SuperSelectDialog({
    required this.context,
    required this.dialogMode,
    this.multiSelect = false
  });*/

  static Future<ItemData?> bottomSheet({
    required BuildContext context,
    required SuperSelectController controller,
    required List<ItemData> items,
    required ItemData? lastItemData,
    bool multiSelect = false,
    Widget? title,
    TextStyle? itemTextStyle,
    double height = double.infinity
  }) {
    return showModalBottomSheet<ItemData>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (BuildContext context) {
          final TextEditingController searchController = TextEditingController();
          List<ItemData> filteredItems = items;

          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  width: double.infinity,
                  height: height,
                  child: Column(
                    children: [
                      if (title != null) title,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                controller._clearAll();
                                Navigator.of(context).pop();
                              },
                              child: Text('Clear selection',
                                  style: TextStyle(decoration: TextDecoration.underline)
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(lastItemData);
                              },
                              child: Text(multiSelect ? 'Done' : 'Close',
                                  style: TextStyle(decoration: TextDecoration.underline)
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: 'Search'
                          ),
                          onChanged: (String? searchString) {
                            setState(() {
                              if (searchString != null) {
                                if (searchString.isNotEmpty) {
                                  // filter it
                                  debugPrint("FILTERING $searchString");
                                  filteredItems = items.where((ItemData testData) {
                                    return testData.text.toLowerCase().contains(searchString.trim().toLowerCase());
                                  }).toList();
                                } else {
                                  debugPrint("FULL LIST");
                                  // full list
                                  filteredItems = items;
                                }
                              } else {
                                filteredItems = items;
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: filteredItems.map((ItemData itemData) {
                              return SuperSelectListItem(
                                context: context,
                                controller: controller,
                                itemData: itemData,
                                textStyle: itemTextStyle,
                                multiSelect: multiSelect,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            );
          });
        }
    );
  }

  static Future<ItemData?> dialog({
    required BuildContext context,
    required SuperSelectController controller,
    required List<ItemData> items,
    bool multiSelect = false,
    Widget? title,
    TextStyle? itemTextStyle,
    double height = double.infinity
  }) {
    return showDialog<ItemData>(
        context: context,
        barrierDismissible: false,
        useSafeArea: true,
        builder: (BuildContext context) {
          final TextEditingController searchController = TextEditingController();
          List<ItemData> filteredItems = items;

          return Dialog(
            child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: double.infinity,
                //height: height,
                child: Column(
                  children: [
                    if (title != null) title,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextButton(
                            onPressed: () {
                              controller._clearAll();
                              Navigator.of(context).pop();
                            },
                            child: Text('Clear selection',
                                style: TextStyle(decoration: TextDecoration.underline)
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(multiSelect ? 'Done' : 'Close',
                                style: TextStyle(decoration: TextDecoration.underline)
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Search'
                        ),
                        onChanged: (String? searchString) {
                          setState(() {
                            if (searchString != null) {
                              if (searchString.isNotEmpty) {
                                // filter it
                                debugPrint("FILTERING $searchString");
                                filteredItems = items.where((ItemData testData) {
                                  return testData.text.toLowerCase().contains(searchString.trim().toLowerCase());
                                }).toList();
                              } else {
                                debugPrint("FULL LIST");
                                // full list
                                filteredItems = items;
                              }
                            } else {
                              filteredItems = items;
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: filteredItems.map((ItemData itemData) {
                            return SuperSelectListItem(
                              context: context,
                              controller: controller,
                              itemData: itemData,
                              textStyle: itemTextStyle,
                              multiSelect: multiSelect,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        }
    );
  }
}