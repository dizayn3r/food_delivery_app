import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final String text;

  const Counter({Key? key, required this.text}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  late int x;
  @override
  void initState() {
    x = int.parse(widget.text);
    super.initState();
  }
  void _decrement(){
    setState(() {
      if(x>0) {
        --x;
      }
    });
  }

  void _increment(){
        setState(() {
          ++x;
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 100).roundToDouble();
    return Row(
      children: [
        SizedBox(
          height: width * 10,
          width:  width * 10,
          child: const Icon(Icons.remove_rounded),
        ),
        IconButton(
          icon: const Icon(Icons.remove_rounded),
          onPressed: _decrement,
        ),
        const VerticalDivider(),
        SizedBox(
          height: width * 10,
          width:  width * 30,
          child: Text("$x"),
        ),
        const VerticalDivider(),
        IconButton(
          icon: const Icon(Icons.add_rounded),
          onPressed: _increment,
        ),
      ],
    );
  }
}
