import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize = Size.fromHeight(50.0);

  final String headerTitle;
  final List<IconButton> actions;
  final IconButton leading;

  CustomHeader(this.headerTitle, this.actions, [this.leading]);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
          this.headerTitle,
          style: Theme.of(context).textTheme.headline1
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      actions: this.actions,
      leading: this.leading,
    );
  }
}