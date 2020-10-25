import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/header.dart';

class CardEditPage extends StatefulWidget {
  @override
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {
  String selectedType = 'Basic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader('Edit Card', [
        IconButton(
          icon: Icon(Icons.check),
          color: Colors.blue,
          onPressed: () { Navigator.pop(context); },
        )
      ],
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () { Navigator.pop(context); },
          )
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    child:Text('Type: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                  DropdownButton<String>(
                    onChanged: (String newType) => { setState(() {
                      selectedType = newType;
                    })},
                    value: selectedType,
                    icon: Icon(Icons.arrow_drop_down),
                    items: [
                      DropdownMenuItem(
                        value: 'Basic',
                        child: Text('Basic'),
                      ),
                      DropdownMenuItem(
                        value: 'Basic+Reversed',
                        child: Text('Basic+Reversed'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Front'
                )
              )
            ),
            Container(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Back'
                )
              )
            )
          ]
        ),
      )
    );
  }
}