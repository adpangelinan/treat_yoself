import 'package:flutter/material.dart';

class AlertFormComment extends StatelessWidget {
  final _formKey;
  final fieldText = TextEditingController();
  final othertext = TextEditingController();
  //final int user;

 // MyCustomFormState(this.user);

  void clearText() {
    fieldText.clear();
    othertext.clear();
  }
  AlertFormComment(this._formKey);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Stack(overflow: Overflow.visible, children: <Widget>[
      Positioned(
        right: -40.0,
        top: -40.0,
        child: InkResponse(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: CircleAvatar(
            child: Icon(Icons.close),
            backgroundColor: Colors.red,
          ),
        ),
      ),
      Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Tell us about your Trip!"),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter Store Name',
                      labelStyle: TextStyle(color: Colors.green)),
                  controller: fieldText),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your comment here',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  controller: othertext),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  FloatingActionButton.extended(
                    label: Text('Submit'),
                    icon: Icon(Icons.add),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                        clearText();
                      }
                    },
                  )
                ],
              )
            ],
          ))
    ]));
  }
}

class AlertFormUpdate extends StatelessWidget {
  final _formKey;
  final fieldText = TextEditingController();
  final othertext = TextEditingController();
  //final int user;

 // MyCustomFormState(this.user);

  void clearText() {
    fieldText.clear();
    othertext.clear();
  }
  AlertFormUpdate(this._formKey);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Stack(overflow: Overflow.visible, children: <Widget>[
      Positioned(
        right: -40.0,
        top: -40.0,
        child: InkResponse(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: CircleAvatar(
            child: Icon(Icons.close),
            backgroundColor: Colors.red,
          ),
        ),
      ),
      Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text("Update Item Price!"),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter Store Name',
                      labelStyle: TextStyle(color: Colors.green)),
                  controller: fieldText),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your Price here',
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  controller: othertext),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  FloatingActionButton.extended(
                    label: Text('Submit'),
                    icon: Icon(Icons.add),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                        clearText();
                      }
                    },
                  )
                ],
              )
            ]))]));
  }
}
