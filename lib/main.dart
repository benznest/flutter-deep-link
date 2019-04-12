import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart' as UniLink;
import 'package:flutter/services.dart' show PlatformException;

Future main() async {
  checkDeepLink();
  runApp(MyApp());
}

Future checkDeepLink() async {
  StreamSubscription _sub;
  try {
    await UniLink.getInitialLink();
    _sub = UniLink.getUriLinksStream().listen((Uri uri) {
      print(uri);
      runApp(MyApp(uri: uri));
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
    });
  } on PlatformException {

  }
}

class MyApp extends StatelessWidget {
  final Uri uri;

  MyApp({this.uri});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "benznest's blog"),
    );
  }
}
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title = "Deep link"}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Deep link',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}