import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

pendingMessage() {
  return const Card(
    color: Colors.white,
    elevation: 0,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Text(
        ' Pending ',
        style: TextStyle(color: CupertinoColors.activeOrange, fontSize: 13),
      ),
    ),
  );
}

approvedMessage() {
  return const Card(
    color: Colors.white,
    elevation: 0,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: Text(
        'Approved',
        style: TextStyle(color: CupertinoColors.activeGreen, fontSize: 13),
      ),
    ),
  );
}
