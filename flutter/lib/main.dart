import 'package:flutter/cupertino.dart';
import 'dart:math' show Random, sqrt;

void main() => runApp(
      CupertinoApp(
        home: ContentPage(),
      ),
    );

class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final rng = Random();
  int rTarget, gTarget, bTarget;
  int rGuess = 0, gGuess = 0, bGuess = 0;

  @override
  initState() {
    rTarget = rng.nextInt(256);
    gTarget = rng.nextInt(256);
    bTarget = rng.nextInt(256);
    super.initState();
  }

  int computeScore() {
    final rDiff = rGuess / 256 - rTarget / 256;
    final gDiff = gGuess / 256 - gTarget / 256;
    final bDiff = bGuess / 256 - bTarget / 256;
    final diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff);
    return ((1.0 - diff) * 100).ceil();
  }

  void displayDialog() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text('Your score'),
              content: Text(computeScore().toString()),
              actions: <Widget>[
                CupertinoButton(
                  child: Text('OK'),
                  onPressed: Navigator.of(context).pop,
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Container(
                              color: Color.fromRGBO(
                                  rTarget, gTarget, bTarget, 1.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text('Match this color'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Container(
                              color:
                                  Color.fromRGBO(rGuess, gGuess, bGuess, 1.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text('R: $rGuess G: $gGuess B: $bGuess'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CupertinoButton(
              child: Text('Hit me!'),
              onPressed: displayDialog,
            ),
            ColorSlider(
              value: rGuess,
              color: CupertinoColors.systemRed,
              onChanged: (double newValue) {
                setState(() {
                  rGuess = newValue.round();
                });
              },
            ),
            ColorSlider(
              value: gGuess,
              color: CupertinoColors.systemGreen,
              onChanged: (double newValue) {
                setState(() {
                  gGuess = newValue.round();
                });
              },
            ),
            ColorSlider(
              value: bGuess,
              color: CupertinoColors.systemBlue,
              onChanged: (double newValue) {
                setState(() {
                  bGuess = newValue.round();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ColorSlider extends StatelessWidget {
  const ColorSlider({
    Key key,
    @required this.value,
    @required this.color,
    @required this.onChanged,
  }) : super(key: key);

  final int value;
  final Color color;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('0', style: TextStyle(color: color)),
        ),
        Expanded(
          child: CupertinoSlider(
              value: value.toDouble(),
              min: 0,
              max: 255,
              onChanged: this.onChanged),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('255', style: TextStyle(color: color)),
        ),
      ],
    );
  }
}
