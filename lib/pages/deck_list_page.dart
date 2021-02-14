import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_flashcards/bloc/decks/decks.dart';
import 'package:flutter_flashcards/error/exceptions.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/widgets/deck_item.dart';

class DeckListPage extends StatefulWidget {
  @override
  _DeckListPageState createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  final textInputController = TextEditingController();
  DeckBloc deckBloc;

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    deckBloc = BlocProvider.of<DeckBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decks', style: Theme.of(context).appBarTheme.textTheme.headline1),
        actions: [
          IconButton(
            icon: Icon(Icons.insert_chart_outlined),
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pushNamed('/statistics');
            }
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          )
        ],
      ),
      body: BlocBuilder<DeckBloc, DeckState>(
        builder: (BuildContext context, DeckState state) {
          if(state is DeckInitial) {
            deckBloc.add(GetDecks());
            return Container();
          } else if(state is DecksLoading) {
            return Container(child: Center(child: CircularProgressIndicator()));
          } else if(state is DecksLoaded) {
            return _buildDecksView(context, state);
          } else if(state is DeckLoaded) {
            deckBloc.add(GetDecks());
            return Container(child: Center(child: CircularProgressIndicator()));
          } else {
            return Container(child: Center(child: Text('Error')));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _showAddDeckDialog();
            }
          );
        },
      ),
    );
  }

  Widget _buildDecksView(BuildContext context, DeckState state) {
    if(state is DecksLoaded) {
      return ListView.builder(
          key: Key('deckList'),
          itemCount: state.decks.length,
          itemBuilder: (BuildContext context, int index) {
            Deck item =  state.decks[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/deck', arguments: item.id).then((value) {
                    deckBloc.add(GetDecks());
                });
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _showOptionsDialog(item);
                    }
                );
              },
              child: DeckItem(deck: item),
            );
          }
      );
    } else {
      throw StateException('Invalid Function call in current State: $state');
    }
  }


  Widget _showOptionsDialog(Deck item) {
    return SimpleDialog(
      title: Text('Delete Deck'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context).pushNamed('/');
            deckBloc.add(DeleteDeck(item.id));
          },
          child: Text('Delete Deck'),
        )
      ],
    );
  }

  Widget _showAddDeckDialog() {
    return AlertDialog(
      title: Text('Add Deck'),
      actions: [
        FlatButton(
          child: Text('Create'),
          onPressed: () async {
            if(textInputController.text.isNotEmpty && textInputController.text.length <= 40) {
              deckBloc.add(AddDeck(Deck(textInputController.text, size: 0, performance: 0)));
              await Navigator.of(context).pushNamed('/');
              textInputController.clear();
            }
          },
        ),
      ],
      content: TextField(
        controller: textInputController,
        maxLength: 40,
        maxLengthEnforced: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Deck Name ',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 0.5
            ),
          ),
        ),
      ),
    );
  }
}