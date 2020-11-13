import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/deck_bloc.dart';
import 'package:flutter_flashcards/bloc/deck_event.dart';
import 'package:flutter_flashcards/bloc/deck_state.dart';
import 'package:flutter_flashcards/components/deck_card.dart';
import 'package:flutter_flashcards/models/deck.dart';

class DeckListPage extends StatefulWidget {
  @override
  _DeckListPageState createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  final textInputController = TextEditingController();
  DeckBloc deckBloc;

  @override
  void initState() {
    super.initState();
    deckBloc = BlocProvider.of<DeckBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    textInputController.dispose();
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
        builder: (context, state) {
          if(state is DeckInitial) {
            deckBloc.add(LoadDecks());
            return _buildInitialView();
          } else if(state is DecksLoading) {
            return _buildLoadingView();
          } else if(state is DecksLoaded) {
            return _buildDecksView(context, state);
          } else if(state is DeckError) {
            return _buildErrorView();
          } else {
            return _buildErrorView();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddDeckDialog();
        },
      ),
    );
  }


  _showOptionsDialog(Deck item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      },
    );
  }

  _showAddDeckDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Deck'),
            actions: [
              FlatButton(
                child: Text('Create'),
                onPressed: () async {
                  if(textInputController.text.isNotEmpty) {
                    Deck newDeck = new Deck(title: textInputController.text);
                    deckBloc.add(AddDeck(newDeck));
                    Navigator.of(context).pushNamed('/');
                    textInputController.clear();
                  }
                },
              ),
            ],
            content: TextField(
              controller: textInputController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Deck Name: ',
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
    );
  }

  Widget _buildInitialView() {
    return Container();
  }

  Widget _buildLoadingView() {
    return Container(
      child: Center(
        child: CircularProgressIndicator()
      )
    );
  }

  Widget _buildDecksView(BuildContext context, DeckState state) {
    if(state is DecksLoaded) {
      return ListView.builder(
          itemCount: state.decks.length,
          itemBuilder: (context, index) {
            Deck item =  state.decks[index];
            return InkWell(
              child: DeckCard(deck: item),
              onTap: () {
                Navigator.of(context).pushNamed('/deck', arguments: item);
              },
              onLongPress: () {
                _showOptionsDialog(item);
              },
            );
          }
      );
    } else {
      throw StateError;
    }
  }

  Widget _buildErrorView() {
    return Container(
      child: Center(
        child: Text('Error'),
      )
    );
  }
}