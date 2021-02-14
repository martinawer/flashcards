import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class FlashcardItem extends StatefulWidget {
  final Flashcard card;
  final Function onLongPress;
  final Function onTap;

  FlashcardItem(this.card, {this.onLongPress, this.onTap});

  @override
  _FlashcardItemState createState() => _FlashcardItemState();
}

class _FlashcardItemState extends State<FlashcardItem> {
  bool isSelected = false;
  Color _cardShadowColor = Colors.black12;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPress,
      onTap: () {
        var res = widget.onTap();
        if(res == null) {
          _selectCard();
        }
      },
      child: Card(
        key: Key('flashcard'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            boxShadow: [
              BoxShadow(blurRadius: 3, offset: Offset(1, 1), color: _cardShadowColor, spreadRadius: 2),
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
                    child: Text('Basic: ${widget.card.type}\nFront: ${widget.card.front}\nBack: ${widget.card.back}'),
                  )
              ),
              // Container(
              //   child: Wrap(
              //       direction: Axis.horizontal,
              //       spacing: 2,
              //       runSpacing: 1,
              //       children: _buildTagsAsClips()
              //   ),
              // )
            ],
          ),
        )
      ),
    );
  }

  void _selectCard() {
    setState(() {
      isSelected = !isSelected;
      _selectColor();
    });
  }

  void _selectColor() {
    if(isSelected) {
      _cardShadowColor = Colors.red;
    } else {
      _cardShadowColor = Colors.black12;
    }
  }

  // List<Widget> _buildTagsAsClips() {
  //   List<Widget> chips = <Widget>[];
  //   if(widget.card.tags != null) {
  //     widget.card.tags.forEach((element) {
  //       chips.add(
  //           Chip(
  //             label: Text(element.name),
  //             backgroundColor: element.color,
  //           )
  //       );
  //     });
  //   }
  //   return chips;
  // }
}