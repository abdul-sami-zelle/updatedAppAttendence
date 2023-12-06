import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/numbersMulti.dart';

class ClockView extends StatelessWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(
        Duration(seconds: 1),
      ),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  MultiNumber(color: Colors.white, subtitle: DateFormat('hh:mm:ss a').format(DateTime.now()), weight: FontWeight.bold, size: 40),
                ],
              ),
              Text(
                DateFormat.yMMMMEEEEd().format(DateTime.now()),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }
}
