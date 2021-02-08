import './item.dart';

class sList {
  int listID;
  String name;
  String owner;
  List<Item> items;

  sList(this.listID, this.name, this.owner, this.items);

  void setListID(int id) {
    listID = id;
  }

  void setListName(String listName) {
    name = listName;
  }

  void setListOwner(String listOwner) {
    owner = listOwner;
  }

  int getListID() {
    return listID;
  }

  String getListName() {
    return name;
  }

  String getOwner() {
    return owner;
  }
}
