class Flashcard {

  int id;
  String type;
  String front;
  String back;

  Flashcard({this.id, this.type, this.front, this.back});

  factory Flashcard.fromMap(Map<String, dynamic> json) => new Flashcard(
    id: json['id'],
    type: json['type'],
    front: json['front'],
    back: json['back'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type,
    'front': front,
    'back': back,
  };
}