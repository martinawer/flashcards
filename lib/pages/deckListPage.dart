import 'package:flutter/material.dart';
import 'package:flutter_flashcards/bloc/deckBloc.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/components/deckCard.dart';
import 'package:flutter_flashcards/components/header.dart';
import 'package:flutter_flashcards/pages/settingsPage.dart';

class DeckListPage extends StatefulWidget {
  @override
  _DeckListPageState createState() => _DeckListPageState();
}

class _DeckListPageState extends State<DeckListPage> {
  final textInputController = TextEditingController();
  final deckBloc = DeckBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    deckBloc.dispose();
    super.dispose();
    textInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader('Decks', [
        IconButton(
          icon: Icon(Icons.settings),
          color: Colors.blue,
          onPressed: () {
            navigateToSettings(context);
          },
        )
      ]),
      body: StreamBuilder<List<Deck>>(
        stream: deckBloc.decks,
        builder: (BuildContext context, AsyncSnapshot<List<Deck>> snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Deck item = snapshot.data[index];
                return DeckCard(deck: item);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add Deck'),
                  content: TextField(
                    controller: textInputController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 0.5
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Deck Name: ',
                    ),
                  ),
                  actions: [
                    FlatButton(
                      child: Text('Create'),
                      onPressed: () async {
                        if(textInputController.text.isNotEmpty) { //TODO: check if deck name is really not empty (e.g. whitespaces)
                          Deck newDeck = new Deck(title: textInputController.text);
                          deckBloc.add(newDeck);
                          Navigator.pop(context);
                          textInputController.clear();
                        }
                      },
                    ),
                  ],
                );
              }
          );
          },
      ),
    );
  }
}

Future navigateToSettings(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) =>
      SettingsPage()
  ));
}