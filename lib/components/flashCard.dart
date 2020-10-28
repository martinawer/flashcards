import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class FlashCardComponent extends StatefulWidget {
  final Flashcard card;
  FlashCardComponent(this.card);
  @override
  _FlashCardComponentState createState() => _FlashCardComponentState();
}

class _FlashCardComponentState extends State<FlashCardComponent> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(blurRadius: 3, offset: Offset(1, 1), color: Colors.black12),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                color: Colors.green,
              ),
            ),
            Container(
                child: Container(
                  child: Text('Basic: ${this.widget.card.type}\nFront: ${this.widget.card.front}\nBack: ${this.widget.card.back}'),
                )
            ),
          ],
        ),
      )
    );
  }
}