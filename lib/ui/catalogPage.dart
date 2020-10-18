import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/ui/header.dart';

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader('Catalog', []),
    );
  }
}