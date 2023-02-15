import 'dart:io';

import 'package:ble_positioning_system/nwarehouse-flow/services/mqtt_const.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class mqtt {
  var client = MqttServerClient.withPort(url, clientId, port);

  void setup() async {
    client.secure = true;
    // Set Keep-Alive
    client.keepAlivePeriod = 20;
    // Set the protocol to V3.1.1 for AWS IoT Core, if you fail to do this you will not receive a connect ack with the response code
    client.setProtocolV311();
    // logging if you wish
    client.logging(on: false);

    // Set the security context as you need, note this is the standard Dart SecurityContext class.
    // If this is incorrect the TLS handshake will abort and a Handshake exception will be raised,
    // no connect ack message will be received and the broker will disconnect.
    // For AWS IoT Core, we need to set the AWS Root CA, device cert & device private key
    // Note that for Flutter users the parameters above can be set in byte format rather than file paths
    final context = SecurityContext.defaultContext;
    ByteData rootCA = await rootBundle.load('assets/ssl/rootCA.pem');
    ByteData deviceCert = await rootBundle.load('assets/ssl/device.pem.crt');
    ByteData privateKey = await rootBundle.load('assets/ssl/private.pem.key');

    context.setClientAuthoritiesBytes(rootCA.buffer.asInt8List());
    context.useCertificateChainBytes(deviceCert.buffer.asInt8List());
    context.usePrivateKeyBytes(privateKey.buffer.asInt8List());
    client.securityContext = context;

    // Setup the connection Message
    final connMess =
        MqttConnectMessage().withClientIdentifier('esp').startClean();
    client.connectionMessage = connMess;
  }

  void connect() async {
    // Connect the client
    try {
      print('MQTT client connecting to AWS IoT using certificates....');
      await client.connect();
    } on Exception catch (e) {
      print('MQTT client exception - $e');
      client.disconnect();
      exit(-1);
    }
  }

  void publish(var topic, var msg) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected to AWS IoT');
      client.publishMessage(topic, MqttQos.atLeastOnce, msg.payload!);
    } else {
      print(
          'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      client.disconnect();
    }
  }

  void nodePublish(bool val) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected to AWS IoT');
      const topic = publishTopic;
      final builder = MqttClientPayloadBuilder();
      builder.addString('{"nodeID":"1234","status":${val}}');
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    }
  }

  void subscribe(var topic) async {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected to AWS IoT');
      // Subscribe to the same topic
      client.subscribe(topic, MqttQos.atLeastOnce);
      // Print incoming messages from another client on this topic
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
        print('');
      });
    } else {
      print(
          'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      client.disconnect();
    }
  }

  void sleep() async {
    print('Sleeping....');
    await MqttUtilities.asyncSleep(10);
  }

  void disconnect() {
    print('Disconnecting');
    client.disconnect();
  }

  mqtt._();

  static final instance = mqtt._();
}
