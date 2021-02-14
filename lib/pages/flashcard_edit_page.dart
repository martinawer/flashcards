import 'package:flutter/material.dart';

import 'package:flutter_flashcards/models/flashcard.dart';
import 'package:flutter_flashcards/widgets/leading_header_button.dart';

class FlashcardEditPage extends StatefulWidget {
  final Flashcard card;
  FlashcardEditPage({@required this.card});

  @override
  _FlashcardEditPageState createState() => _FlashcardEditPageState();
}

class _FlashcardEditPageState extends State<FlashcardEditPage> {
  TextEditingController frontInputController;
  TextEditingController backInputController;
  String cardType;

  @override
  void initState() {
    super.initState();
    cardType = widget.card.type;
    frontInputController = TextEditingController(text: widget.card.front);
    backInputController = TextEditingController(text: widget.card.back);
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
              Navigator.of(context).pop(
                Flashcard(
                    id: widget.card.id,
                    type: cardType,
                    front: frontInputController.text,
                    back: backInputController.text,
                    deckId: widget.card.deckId
                )
              );
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
                       cardType = newType;
                      })
                    },
                    value: cardType ??= 'Basic',
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
            //TODO: add check, inputcontroller should not be empty
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