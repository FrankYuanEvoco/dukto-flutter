import 'dart:convert';
import 'dart:io';

import 'package:dukto_flutter/core/dukto_constants.dart';
import 'package:dukto_flutter/core/dukto_protocol.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test tcp connection', () async {
    var myProtocol = DuktoProtocol();
    await myProtocol.init();
    Future.delayed(Duration(milliseconds: 500), () async {
      Socket newData = await Socket.connect('127.0.0.1', DuktoConst.tcpPort);
      newData.add(ascii.encode('hello'));
      await Future.delayed(Duration(seconds: 1));
      newData.close();
    });
    var res = ascii.decode(
        await (await myProtocol.tcpSocketDataObserver.stream.first).first);
    expect(res, 'hello');
  });
}
