import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_flashcards/bloc/decks/decks.dart';
import 'package:flutter_flashcards/bloc/tags/tags.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/models/tag.dart';
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
  TagBloc tagBloc;

  @override
  void initState() {
    deckBloc = BlocProvider.of<DeckBloc>(context);
    tagBloc = BlocProvider.of<TagBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeckBloc, DeckState>(
      builder: (BuildContext context, DeckState state) {
        if(state is DeckLoaded) {
          return _buildPreview(state.deck);
        } else if(state is DeckError) {
          return ErrorPage('There is an issue with your Deck.');
        } else if(state is DecksLoaded) {
          return _buildPreview(state.decks.firstWhere((element) => element.id == widget.deckId));
        } else {
          return Container(child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _buildPreview(Deck deck) {
    return Scaffold(
        appBar: AppBar(
            title: Text(deck.title, style: Theme.of(context).appBarTheme.textTheme.headline1),
            leading: LeadingHeaderButton()
        ),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Learn ${deck.title}', style: Theme.of(context).appBarTheme.textTheme.headline1),
                  SizedBox(height: 15),
                  ButtonTheme(
                      minWidth: 200,
                      height: 46,
                      child: _buildLearnButton(deck)
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
                        Navigator.of(context).pushNamed('/edit', arguments: deck).then((d) {
                          deckBloc.add(GetDeck(widget.deckId));
                        });
                      },
                      label: Text('Edit', style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                  BlocBuilder<TagBloc, TagState>(
                    builder: (BuildContext context, TagState state) {
                      if(state is TagInitial) {
                        tagBloc.add(GetDeckTags(widget.deckId));
                        return Container();
                      } else if(state is TagsLoading) {
                        return LinearProgressIndicator();
                      } else if(state is TagsLoaded) {
                        return buildTagChips(state.tags);
                      } else if(state is TagError) {
                        return Container();
                      } else {
                        return Container(child: Text('Something went wrong'));
                      }
                    },
                  )
                ]
            )
        )
    );
  }

  Widget buildTagChips(List<Tag> tags) {
    List<Widget> chips = <Widget>[];
    tags.forEach((element) {
      chips.add(
          Chip(
            label: Text(element.name),
            backgroundColor: element.color,
          )
      );
    });
    return Wrap(
      direction: Axis.horizontal,
      spacing: 2,
      runSpacing: 1,
      children: chips,
    );
  }

  Widget _buildLearnButton(Deck deck) {
    return RaisedButton.icon(
      icon: Icon(Icons.play_arrow),
      textColor: Colors.white,
      color: Colors.green,
      label: Text('Learn', style: Theme.of(context).textTheme.bodyText1),
      onPressed: _startLearning(deck)
    );
  }

  Function _startLearning(Deck deck) {
    if(deck.size > 0) {
      return () { Navigator.of(context).pushNamed('/learn', arguments: deck); };
    } else {
      return null;
    }
  }
}