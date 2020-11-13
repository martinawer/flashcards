import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/card_bloc.dart';
import 'package:flutter_flashcards/bloc/card_event.dart';
import 'package:flutter_flashcards/bloc/card_state.dart';
import 'package:flutter_flashcards/components/leading_header_button.dart';
import 'package:flutter_flashcards/components/learn_card.dart';
import 'package:flutter_flashcards/models/deck.dart';

class LearnPage extends StatefulWidget {
  final Deck deck;
  LearnPage({@required this.deck});

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  CardBloc cardBloc;
  bool isFront;

  @override
  void initState() {
    super.initState();
    cardBloc = BlocProvider.of<CardBloc>(context);
    isFront = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn', style: Theme.of(context).textTheme.headline1),
        leading: LeadingHeaderButton(),
      ),
      body: BlocBuilder<CardBloc, CardState>(
        buildWhen: (previous, current) {
          if(previous is CardInitial && current is CardsLoading) {
            return true;
          } else if(previous is CardsLoading && current is CardsLoaded) {
            return true;
          } else {
            return false;
          }
        },
        builder: (BuildContext context, CardState state) {
          if(state is CardInitial) {
            cardBloc.add(LoadCards(widget.deck.id));
            return _buildInitialView();
          } else if(state is CardsLoading){
            return _buildLoadingView();
          } else if(state is CardsLoaded) {
            return Container(
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: LearnCard(text: 'Builder Yes'),
                        onTap: () {
                          _updateCard();
                        },
                      ),
                    ],
                  ),
                  _buildReflectionButtons()
                ],
              ),
            );
          } else {
            return _buildErrorView();
          }
        },
      )
    );
  }

  Widget _buildReflectionButtons() {
    if(isFront == false) {
      return Row();
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              child: Text('Good'),
              textColor: Colors.green,
              onPressed: () {},
            ),
            FlatButton(
              child: Text('OK'),
              textColor: Colors.orangeAccent,
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Bad'),
              textColor: Colors.red,
              onPressed: () {},
            )
          ]
      );
    }

  }

  Widget _buildLoadingView() {
    return Card(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildInitialView() {
    return Card();
  }

  Widget _buildErrorView() {
    return Card(
      child: Center(child: Text('Error'))
    );
  }

  void _updateCard() {
    if(isFront == true) {
      setState(() { isFront = false;});
    } else {
      setState(() { isFront = true;});
    }
  }

}
