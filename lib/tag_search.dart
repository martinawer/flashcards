import 'package:flutter/material.dart';
import 'package:flutter_flashcards/models/tag.dart';
import 'package:flutter_flashcards/widgets/leading_header_button.dart';

class TagSearch extends SearchDelegate<Tag> {
  final List<Tag> tags;
  TagSearch(this.tags);

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
    final results = tags.where((t) => t.name.toLowerCase().contains(query));

    return Column(
      children: results.map<Widget>((t) => InkWell(
        onTap: () {

        },
        child: Row(
            children: [
              Icon(Icons.add), SizedBox(width: 5) ,Chip(label: Text(t.name), backgroundColor: t.color)
            ]
        ),
      )).toList()..add(_buildCreateTagField(context)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = tags.where((t) => t.name.toLowerCase().contains(query));

    return Column(
      children: results.map<Widget>((t) => InkWell(
        onTap: () {
          //TODO: add exisiting tag to card
          close(context, t);
        },
        child: Row(
          children: [
            Icon(Icons.add), SizedBox(width: 5) ,Chip(label: Text(t.name), backgroundColor: t.color)
          ]
        ),
      )).toList()..add(_buildCreateTagField(context)),
    );
  }

  Widget _buildCreateTagField(BuildContext context) {
    if(query.isNotEmpty) {
      return InkWell(
        onTap: () {
          //TODO: add new tag and update card + deck
          close(context, Tag(query));
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