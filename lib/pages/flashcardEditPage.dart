import 'package:flutter/material.dart';
import 'package:flutter_flashcards/bloc/cardBloc.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class CardEditPage extends StatefulWidget {
  final int deckId;
  final Flashcard card;
  CardEditPage(this.deckId, { this.card });
  @override
  _CardEditPageState createState() => _CardEditPageState();
}

class _CardEditPageState extends State<CardEditPage> {


  TextEditingController frontInputController;
  TextEditingController backInputController;
  CardBloc cardBloc;
  Flashcard newCard;
  String selectedType;

  @override
  void initState() {
    super.initState();
    newCard = widget.card != null ? widget.card : new Flashcard();
    selectedType = widget.card != null ? widget.card.type : 'Basic';
    frontInputController = TextEditingController(text: newCard.front);
    backInputController = TextEditingController(text: newCard.back);
    cardBloc = new CardBloc(widget.deckId);
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
              newCard.type = selectedType;
              newCard.front = frontInputController.text;
              newCard.back = backInputController.text;
              newCard.deckId = widget.deckId;
              Navigator.pop(context, newCard);
            },
          )
        ],
        leading: IconButton(
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