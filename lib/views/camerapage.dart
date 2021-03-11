import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:treat_yoself/routes.dart';
import 'components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/shoppinglists_controller.dart';
import 'package:get/get.dart';
import 'package:treat_yoself/utils/database/db_utils.dart';

//sources cited:  https://pub.dev/packages/flutter_barcode_scanner/example

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    super.initState();
  }

  Future attempUpdate(barcodeScanRes) async {
    var value = await showDialog(
        context: context,
        builder: (BuildContext context) {
          final _updatePricekey = GlobalKey<FormState>();
          return AlertFormModUpdate(_updatePricekey, barcodeScanRes);
        });
    return value;
  }

  Future attemptAdd(barcodeScanRes) async {
    final ShoppingListController curLis = Get.find();
    var listID = curLis
        .currentList.listID; //add user data class to extract this id from it
    var database = DatabaseEngine();
    var selectitemID = "Select BrandItemID from BrandsItems where BarCode = ?";
    var insertquery = "Insert Into ListItems VALUES(NULL,?,?,1)";
    var id = await database.manualQuery(selectitemID, [barcodeScanRes]);
    if (id.length == 0) {
      return false;
    } else {
      await database.manualQuery(insertquery, [listID, id[0].values[0]]);
      return true;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal(context) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      if (barcodeScanRes != "-1") {
        var add = await attemptAdd(barcodeScanRes);
        if (add) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Item Added to cart"),
          ));
        } else {
          Get.to(MyCustomForm(barcode: barcodeScanRes));
        }
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("No Item was scanned"),
        ));
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to get platform version"),
      ));
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Future<void> scanBarcodeupdatePrice(context) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      var add = await attempUpdate(barcodeScanRes);
      if (add) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Item Updated"),
        ));
      } else {
        Get.to(MyCustomForm(barcode: barcodeScanRes,));
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to get platform version"),
      ));
    } on AssertionError {
      Get.to(MyCustomForm());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Scan Barcode")),
        body: Builder(
          builder: (BuildContext context) {
            return buildBody(context);
          },
        ),
        //resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BotNavBar());
  }

  Widget buildBody(context) {
    return Container(
        alignment: Alignment.center,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 150, height: 150),
              child: ElevatedButton( //https://www.kindacode.com/article/how-to-make-circular-buttons-in-flutter/
                child: Text('Scan Item to Add to Cart', style: TextStyle(fontSize: 20),),
                onPressed: () => scanBarcodeNormal(context),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
              ),
            ),
            SizedBox(height:30.00),
               ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 150, height: 150),
              child: ElevatedButton(
                child: Text('Scan Item to Update Price', style: TextStyle(fontSize: 20),),
                onPressed: () => scanBarcodeupdatePrice(context),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                ),
              ),
            ),
            
            ]));
  }
}
