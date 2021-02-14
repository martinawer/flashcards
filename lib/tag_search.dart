import 'package:flutter/material.dart';
import 'package:flutter_flashcards/bloc/tags/tags.dart';
import 'package:flutter_flashcards/models/tag.dart';
import 'package:flutter_flashcards/pages/error_page.dart';
import 'package:flutter_flashcards/widgets/leading_header_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagSearch extends SearchDelegate<Tag> {
  final Bloc<TagEvent, TagState> tagBloc;
  TagSearch(this.tagBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return LeadingHeaderButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      cubit: tagBloc,
      builder: (BuildContext context, TagState state) {
        if(state is TagsLoaded) {
          final results = state.tags.where((t) => t.name.toLowerCase().contains(query));
          return Column(
            children: results.map<Widget>((t) => InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.add), SizedBox(width: 5), Chip(label: Text(t.name), backgroundColor: t.color)
                ]
              ),
            )).toList()..add(_buildCreateTagField(context)),
          );
        } else {
          return ErrorPage('Something went wrong with searching Tags.');
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //TODO: should be a listview
    return BlocBuilder<TagBloc, TagState>(
      cubit: tagBloc,
      builder: (BuildContext context, TagState state) {
        if(state is TagsLoaded) {
          final results = state.tags.where((t) => t.name.toLowerCase().contains(query));
          return Column(
            children: results.map<Widget>((t) => InkWell(
              onTap: () {},
              child: Row(
                  children: [
                    Icon(Icons.add), SizedBox(width: 5), Chip(label: Text(t.name), backgroundColor: t.color)
                  ]
              ),
            )).toList()..add(_buildCreateTagField(context)),
          );
        } else {
          return ErrorPage('Something went wrong with searching Tags.');
        }
      },
    );
  }

  Widget _buildCreateTagField(BuildContext context) {
    if(query.isNotEmpty) {
      return InkWell(
        onTap: () {
          //TODO: add new tag and update card + deck
          //TODO: add deck id to tag after navigation
          close(context, Tag(query, deck_id: 0));
        },
        child: Row(
          children: [
            SizedBox(width: 5),
            Text('Create ', style: Theme.of(context).textTheme.headline2),
            SizedBox(width: 5),
            Chip(label: Text(query), backgroundColor: Colors.cyanAccent),
          ]
        ),
      );
    }
    return Container();
  }
  
}