part of '../super_select.dart';

class SuperSelectController extends ChangeNotifier {
  bool _multiSelect = false;
  List<ItemData> _selectedItems = [];
  ItemData? _selectedItem;

  dynamic get result {
    if (_multiSelect) {
      return _selectedItems;
    } else {
      return _selectedItem;
    }
  }

  set selectedItem(ItemData? itemData) {
    _selectedItem = itemData;
  }

  ItemData? get selectedItem {
    return _selectedItem;
  }

  set selectedItems(List<ItemData> itemDataList) {
    _selectedItems = itemDataList;
  }

  List<ItemData> get selectedItems {
    return _selectedItems;
  }

  String get selectedItemText {
    return _selectedItem?.text ?? '';
  }

  void _setItem(ItemData? itemData) {
    _selectedItem = itemData;
    notifyListeners();
  }

  void _addItem(ItemData itemData) {
    _selectedItems.add(itemData);
    notifyListeners();
  }

  void _removeItem(ItemData itemData) {
    _selectedItems.remove(itemData);
    notifyListeners();
  }

  void _clearAll() {
    _selectedItem = null;
    _selectedItems.clear();
    notifyListeners();
  }
}