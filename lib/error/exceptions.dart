///thrown from remote data sources
class ServerException implements Exception {}

///thrown from local data sources
class CacheException implements Exception {}

///thrown when cards are invalid
class CardException implements Exception {
  final String message;
  CardException(this.message);
}

///thrown when decks are invalid
class DeckException implements Exception {
  final String message;
  DeckException(this.message);
}

///thrown when a bloc used a method in an invalid state
class StateException implements Exception {
  final String message;
  StateException(this.message);
}