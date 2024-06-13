import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';

class CongratCard extends StatelessComponent {
  @override
  Widget builder(BuildContext context) {
    return Container(
      height: 200,
      width: screenSize.width,
      margin: EdgeInsets.only(left: 50, right: 50),
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '👌',
              style: TextStyle(fontSize: 70),
            ),
            Text(
              'It works pecfectly',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[500]),
            )
          ],
        ),
      ),
    );
  }
}
