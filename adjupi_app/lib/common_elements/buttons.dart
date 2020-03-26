import 'package:flutter/material.dart';
import 'package:homepi_client/api/responses.dart';

import '../enums.dart';

typedef OnSwitchPressed = void Function(SwitchState state);

class OnOffSwitch extends StatefulWidget {
  final OnSwitchPressed onSwitchPressed;

  const OnOffSwitch({Key key, this.onSwitchPressed}) : super(key: key);

  @override
  OnOffSwitchState createState() => OnOffSwitchState();
}

class OnOffSwitchState extends State<OnOffSwitch> {
  Future<StandardResponse> switchResponse;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          FirstButton(
            name: "ON",
            backgroundColor: Colors.green,
            onPressed: () => widget.onSwitchPressed(SwitchState.ON),
          ),
          FirstButton(
            name: "OFF",
            backgroundColor: Colors.red,
            onPressed: () => widget.onSwitchPressed(SwitchState.OFF),
          ),
        ],
      ),
    );
  }
}

class FirstButton extends StatelessWidget {
  final String name;
  final Color backgroundColor;
  final Function onPressed;

  const FirstButton({
    Key key,
    this.name,
    this.backgroundColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      color: backgroundColor,
      child: FlatButton(
        child: Text(name),
        onPressed: onPressed,
      ),
    );
  }
}