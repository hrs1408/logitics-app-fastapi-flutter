import 'package:app/models/work_position.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

class PositionSubScreen extends StatelessWidget {
  final WorkPosition position;

  const PositionSubScreen({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(position.positionName),
          Text(position.users.length.toString()),
          ...List.generate(position.users.length,
              (index) => buildUserItem(position.users[index])),
        ],
      ),
    ));
  }

  Container buildUserItem(User user) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //shadow
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Row(
        children: [Text(user.email)],
      ),
    );
  }
}
