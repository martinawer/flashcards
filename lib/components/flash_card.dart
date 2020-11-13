import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class FlashCardComponent extends StatelessWidget {
  final Flashcard card;
  FlashCardComponent(this.card);

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
                  child: Text('Basic: ${this.card.type}\nFront: ${this.card.front}\nBack: ${this.card.back}'),
                )
            ),
          ],
        ),
      )
    );
  }
}