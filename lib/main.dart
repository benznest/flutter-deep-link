import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_deep_link/second_page.dart';
import 'package:uni_links/uni_links.dart' as UniLink;
import 'package:flutter/services.dart' show PlatformException;

 main()  {
   checkDeepLink();
   runApp(MyApp());
}

Future checkDeepLink() async {
  StreamSubscription _sub;
  try {
    print("checkDeepLink");
    await UniLink.getInitialLink();
    _sub = UniLink.getUriLinksStream().listen((Uri uri) {
      print(uri);
      runApp(MyApp(uri: uri));
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed

      print("onError");
    });
  } on PlatformException {
    print("PlatformException");
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
      home: MyHomePage(uri: uri),
    );
  }
}
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.uri}) : super(key: key);
  final Uri uri;


  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((_){
      if(uri != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(uri)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("benznest's blog"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Deep link",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}