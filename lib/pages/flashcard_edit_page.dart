import 'package:flutter/material.dart';
import 'package:flutter_flashcards/components/leading_header_button.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class FlashcardEditPage extends StatefulWidget {
  final Flashcard card;
  FlashcardEditPage({@required this.card});

  @override
  _FlashcardEditPageState createState() => _FlashcardEditPageState();
}

class _FlashcardEditPageState extends State<FlashcardEditPage> {
  TextEditingController frontInputController;
  TextEditingController backInputController;
  Flashcard newCard;

  @override
  void initState() {
    super.initState();
    newCard = widget.card;
    frontInputController = TextEditingController(text: newCard.front);
    backInputController = TextEditingController(text: newCard.back);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card', style: Theme.of(context).appBarTheme.textTheme.headline1),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            color: Colors.blue,
            onPressed: () {
              newCard.front = frontInputController.text;
              newCard.back = backInputController.text;
              Navigator.of(context).pop(newCard);
            },
          )
        ],
        leading: LeadingHeaderButton(),
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
                    onChanged: (String newType) => {
                      setState(() {
                       newCard.type = newType;
                      })
                    },
                    value: newCard.type == null ? newCard.type = 'Basic' : newCard.type,
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
                controller: frontInputController,
                decoration: const InputDecoration(
                  labelText: 'Front',
                ),
              )
            ),
            Container(
              child: TextFormField(
                controller: backInputController,
                decoration: const InputDecoration(
                  labelText: 'Back'
                )
              )
            )
          ],
        ),
      )
    );
  }
}