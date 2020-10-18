import 'package:flutter/material.dart';
import 'package:flutter_flashcards/ui/catalogPage.dart';
import 'package:flutter_flashcards/ui/deckListPage.dart';
import 'package:flutter_flashcards/ui/statisticPage.dart';

class Destination {
  const Destination(this.title, this.icon, this.color, this.page);
  final String title;
  final IconData icon;
  final MaterialColor color;
  final Widget page;
}

List<Destination> allDestinations = <Destination>[
  Destination('Decks', Icons.home, Colors.teal, DeckListPage()),
  Destination('Statistics', Icons.business, Colors.cyan, StatisticPage()),
  Destination('Catalog', Icons.school, Colors.orange, CatalogPage()),
];