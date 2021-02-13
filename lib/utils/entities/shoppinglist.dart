import './item.dart';

class sList {
  String listID;
  String name;
  String owner;
  String fuid;
  List<Item> items;

  sList(this.listID, this.name, this.owner, this.fuid, this.items);

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
