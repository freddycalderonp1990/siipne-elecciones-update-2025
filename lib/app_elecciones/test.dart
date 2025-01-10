import 'package:flutter/material.dart';

class SampleDialog extends StatefulWidget {
  static const routeName = '/SampleDialog';
  @override
  _SampleDialogState createState() => _SampleDialogState();
}

enum ButtonAction {
  cancel,
  agree,
}

class _SampleDialogState extends State<SampleDialog> {

  void showMaterialDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }




  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Material(
          child: Text("Test")
      ),
    );
  }

}