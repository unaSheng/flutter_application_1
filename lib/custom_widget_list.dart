
import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class CustomListPage extends StatelessWidget {
  
  const CustomListPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget> [
        TitleSection(name: 'nnamenamenamenameamename', location: 'locationlocationlocationlocationlocation'),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Album'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
        ),
      ],
    );
  }
}