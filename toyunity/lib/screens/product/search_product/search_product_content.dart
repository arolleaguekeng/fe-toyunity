import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchToyContent extends StatefulWidget {
  const SearchToyContent({Key? key}) : super(key: key);

  @override
  State<SearchToyContent> createState() => _SearchToyContent();
}

class _SearchToyContent extends State<SearchToyContent> {
  bool isLoading = true;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container();
  }
}
