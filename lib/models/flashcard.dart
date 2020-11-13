class Flashcard {

  int id;
  String type;
  String front;
  String back;
  int deckId;

  Flashcard({this.id, this.type, this.front, this.back, this.deckId});

  ///DB Conversions

  factory Flashcard.fromMap(Map<String, dynamic> json) => new Flashcard(
    id: json['id'],
    type: json['type'],
    front: json['front'],
    back: json['back'],
    deckId: json['deckId'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type,
    'front': front,
    'back': back,
    'deckId': deckId,
  };
}