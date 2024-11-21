part of '../super_select.dart';

enum ItemsValueType { int, double, string, bool }
enum DialogMode { dialog, bottomSheet }

class ItemData {
  const ItemData(this.value, this.text);
  final dynamic value;
  final String text;
}