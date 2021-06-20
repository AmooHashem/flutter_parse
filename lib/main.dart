import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  final keyApplicationId = 'FAEpooWsdL1NRHxbolOAxa39xl6Y9MsdC2dw4paI';
  final keyClientKey = 'mjrkLjcWBwQIc9FbeuF93LZf3sh7EWhhJ0oQAY1o';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  checkConnection();
}

void checkConnection() async {
  var firstObject = ParseObject('Test')
    ..set('message', 'First message from Flutter! Parse is now connected');
  await firstObject.save();
  print('done');
}