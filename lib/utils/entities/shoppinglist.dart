import './shoppingitem.dart';

class ShoppingList {
  String listID;
  String name;
  String owner;
  String fuid;
  List<ShoppingItem> items;

  ShoppingList(this.listID, this.name, this.owner, this.fuid, this.items);

  void setListID(String id) {
    listID = id;
  }

  void setListName(String listName) {
    name = listName;
  }

  void setListOwner(String listOwner) {
    owner = listOwner;
  }

  String getListID() {
    return listID;
  }

  String getListName() {
    return name;
  }

  String getOwner() {
    return owner;
  }
}
