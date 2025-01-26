import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';

/*
 * @Author Champlain Marius Bakop
 * @email champlainmarius20@gmail.com
 * @github [ChamplainLeCode](https://github.com/ChamplainLeCode)
 * 
 */
class IconBadge extends StatelessComponent {
  final double size;
  final int number;
  final IconData icon;
  final Function callBack;
  final Color color;

  final Color badgeColor;

  IconBadge(
      {super.key,
      this.size = 50,
      this.number = 0,
      required this.icon,
      required this.callBack,
      required this.color,
      this.badgeColor = Colors.transparent})
      : assert(number >= 0);

  @override
  Widget builder(BuildContext context) {
    return Container(
      width: size,
      margin: EdgeInsets.only(left: 1),
      height: size,
      child: Stack(
        children: [
          Positioned(
              left: -size / 2,
              bottom: -size / 2,
              child: IconButton(
                icon: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
                onPressed: () => callBack(),
              )),
          if (number > 0)
            Positioned(
                right: 0,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: badgeColor),
                  height: 12,
                  width: 15,
                  alignment: Alignment.center,
                  child: Text(
                    '$number',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ))
        ],
      ),
    );
  }
}
