import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StupidPage extends StatefulWidget {
  StupidPage({Key key}) : super(key: key);

  @override
  _StupidPageState createState() => _StupidPageState();
}

class _StupidPageState extends State<StupidPage> {
  int _count = 1;
  GetStorage box = GetStorage();

  @override
  void initState() {
    if (box.read('count') != null) {
      _count = box.read('count');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Count $_count"),
            ElevatedButton(
              onPressed: () {
                box.write('count', _count + 1);
                setState(() => _count++);
                ;
              },
              child: Text("Increase"),
            ),
          ],
        ),
      ),
    );
  }
}
