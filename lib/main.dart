import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'Login.dart';
import 'Message.dart';
import 'UserPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'FAEpooWsdL1NRHxbolOAxa39xl6Y9MsdC2dw4paI';
  final keyClientKey = 'mjrkLjcWBwQIc9FbeuF93LZf3sh7EWhhJ0oQAY1o';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> hasUserLogged() async {
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(
            currentUser.get<String>('sessionToken')!);

    if (!parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter - Parse Server',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<bool>(
          future: hasUserLogged(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Scaffold(
                  body: Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  ),
                );
                break;
              default:
                if (snapshot.hasData && snapshot.data!) {
                  print("1");
                  return UserPage();
                } else {
                  print("2");
                  return LoginPage();
                }
            }
          }),
    );
  }
}
