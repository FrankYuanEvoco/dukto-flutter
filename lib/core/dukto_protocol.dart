import 'dart:async';
import 'dart:io';

import 'package:dukto_flutter/core/dukto_constants.dart';

class DuktoProtocol {
  RawDatagramSocket? mUdpSocket;
  ServerSocket? mTcpSocket;
  StreamController<RawSocketEvent> udpSocketDataObserver =
      StreamController.broadcast();
  StreamController<Socket> tcpSocketDataObserver = StreamController.broadcast();

  Future<void> init() async {
    mUdpSocket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4, DuktoConst.udpPort,
        reusePort: true);
    mTcpSocket = await ServerSocket.bind(
        InternetAddress.anyIPv4, DuktoConst.tcpPort,
        shared: true);
    mUdpSocket!.listen(onUdpSocketData);
    mTcpSocket!.listen(onTcpSocketData);
  }

  void onUdpSocketData(RawSocketEvent data) {
    udpSocketDataObserver.sink.add(data);
  }

  void onTcpSocketData(Socket data) {
    tcpSocketDataObserver.sink.add(data);
  }
}
