import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flashcards/bloc/cards/cards.dart';
import 'package:flutter_flashcards/widgets/leading_header_button.dart';
import 'package:flutter_flashcards/widgets/learn_card.dart';
import 'package:flutter_flashcards/models/deck.dart';
import 'package:flutter_flashcards/models/flashcard.dart';

class LearnPage extends StatefulWidget {
  final Deck deck;
  LearnPage({@required this.deck});

  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  CardBloc cardBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cardBloc = BlocProvider.of<CardBloc>(context);
    cardBloc.add(LoadCards(widget.deck.id));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn', style: Theme.of(context).textTheme.headline1),
        leading: LeadingHeaderButton(),
      ),
      body: BlocBuilder<CardBloc, CardState>(
        buildWhen: (CardState previous, CardState current) {
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
            return _buildInitialView();
          } else if(state is CardsLoading){
            return _buildLoadingView();
          } else if(state is CardsLoaded) {
            return _buildCard(state.cards);
          } else {
            return _buildErrorView();
          }
        },
      )
    );
  }

  Widget _buildCard(List<Flashcard> cards) {
    return LearnCard(cards: cards);
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
      child: Center(
        child: Text('Error')
      )
    );
  }
}
