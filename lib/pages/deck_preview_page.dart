import 'package:flutter_flashcards/bloc/decks/deck_bloc.dart';
import 'package:flutter_flashcards/bloc/decks/deck_event.dart';
import 'package:flutter_flashcards/bloc/decks/deck_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/pages/error_page.dart';
import 'package:flutter_flashcards/widgets/leading_header_button.dart';

class DeckPreviewPage extends StatefulWidget {
  final int deckId;
  DeckPreviewPage({@required this.deckId});

  @override
  _DeckPreviewPageState createState() => _DeckPreviewPageState();
}

class _DeckPreviewPageState extends State<DeckPreviewPage> {
  Deck deck;
  DeckBloc deckBloc;
  bool _isLearnButtonDisabled;

  @override
  void initState() {
   //_isLearnButtonDisabled = widget.deck.size == 0 ? false : true;
    deckBloc = BlocProvider.of<DeckBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deckBloc.add(GetDeck(widget.deckId));

    return BlocBuilder<DeckBloc, DeckState>(
      builder: (BuildContext context, DeckState state) {
        if(state is DeckLoaded) {
          print('deckPreviewPage: ${state.deck.toMap()}');
          return Scaffold(
            appBar: AppBar(
              title: Text(state.deck.title, style: Theme.of(context).appBarTheme.textTheme.headline1),
              leading: LeadingHeaderButton()
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Learn ${state.deck.title}', style: Theme.of(context).appBarTheme.textTheme.headline1),
                  SizedBox(height: 15),
                  ButtonTheme(
                    minWidth: 200,
                    height: 46,
                    child: _buildLearnButton(state.deck)
                  ),
                  SizedBox(height: 8),
                  ButtonTheme(
                    minWidth: 200,
                    height: 50,
                    child: RaisedButton.icon(
                      icon: Icon(Icons.edit),
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/edit', arguments: state.deck).then((isNotEmpty) {
                          setState(() {
                            _isLearnButtonDisabled = isNotEmpty;
                          });
                        });
                      },
                      label: Text('Edit', style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 2,
                    runSpacing: 1,
                    children: _buildTagsAsClips(state.deck)
                  )
                ]
              )
            )
          );
        } else if(state is DeckError) {
          return Error404Page();
        } else {
          return Container(color: Colors.white, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  List<Widget> _buildTagsAsClips(Deck deck) {
    List<Widget> chips = <Widget>[];
    deck.tags.forEach((element) {
      chips.add(
        Chip(
          label: Text(element.name),
          backgroundColor: element.color,
        )
      );
    });
    return chips;
  }

  Widget _buildLearnButton(Deck deck) {
    return RaisedButton.icon(
      icon: Icon(Icons.play_arrow),
      textColor: Colors.white,
      color: Colors.green,
      label: Text('Learn', style: Theme.of(context).textTheme.bodyText1),
      onPressed: () {
        if(deck.size > 0) {
          return _startLearning(deck);
        }
        return null;
      }
    );
  }

  void _startLearning(Deck deck) {
    if(deck.size > 0) {
      Navigator.of(context).pushNamed('/learn', arguments: deck);
    }
  }
}