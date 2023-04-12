import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToyListContent extends StatefulWidget {
  const ToyListContent({Key? key}) : super(key: key);

  @override
  State<ToyListContent> createState() => _ToyListContent();
}

class _ToyListContent extends State<ToyListContent> {
  bool isLoading = true;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container();
  }
}
