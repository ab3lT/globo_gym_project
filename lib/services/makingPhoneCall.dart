// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:matcher/matcher.dart';

_makingPhoneCall() async {
  var url = Uri.parse("tel:+251943317021");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class CallSupport extends StatelessWidget {
  const CallSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final number = '+251943317021';

    return Scaffold(
        body: AlertDialog(
      title: Text('Call to support'),
      content: SingleChildScrollView(
        child: Column(
          children: [Text('Call us and Give us a comment. ')],
        ),
      ),
      actions: [
        ElevatedButton(
            child: Text('Call'),
            onPressed: () async {
              launch('tel://$number');
              await FlutterPhoneDirectCaller.callNumber(number);
            }),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('cancel')),
      ],
    ));
  }
}
