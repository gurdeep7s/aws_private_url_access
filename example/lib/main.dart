import 'dart:typed_data';

import 'package:aws_s3_private_flutter/aws_s3_private_flutter.dart';
import 'package:aws_s3_private_flutter/export.dart';
import 'package:flutter/material.dart';
import 'package:aws_request/aws_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List? _bytesImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AWS S3 Flutter Demo'),
        ),
        body: _body(),
      ),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          _bytesImage != null ? Image.memory(_bytesImage!) : Container(),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              final AwsS3PrivateFlutter awsS3PrivateFlutter = AwsS3PrivateFlutter(
                  region: "",
                  accessKey: "",
                  secretKey: "",
                  host: '',

                  /// note : [bucketId] is not required when you are request from web platform
                  bucketId: '');
              // setState(() async {
              Response response =
                  await awsS3PrivateFlutter.getObjectWithSignedRequest(key: "");
              if (response!.statusCode == 200) {
                debugPrint('${response!.statusCode}');
                _bytesImage = response.bodyBytes;
                setState(() {});
              }
              // });
            },
            child: Container(
                width: 100,
                height: 50,
                color: Colors.blue,
                child: const Center(
                    child: Text(
                  'Get Object',
                  style: TextStyle(color: Colors.white),
                ))),
          ),
        ],
      ),
    );
  }
}
