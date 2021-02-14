import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/models/tag.dart';

///Events are Use cases of the bloc
abstract class TagEvent extends Equatable {
  const TagEvent();
}

class GetDeckTags extends TagEvent {
  final int deck_id;
  const GetDeckTags(this.deck_id);

  @override
  List<Object> get props => [deck_id];
}

class GetCardTags extends TagEvent {
  final int card_id;
  const GetCardTags(this.card_id);

  @override
  List<Object> get props => [card_id];
}

class AddDeckTag extends TagEvent {
  final Tag newTag;
  const AddDeckTag(this.newTag);

  @override
  List<Object> get props => [newTag];
}

class AddCardTag extends TagEvent {
  final int card_id;
  final int tag_id;
  const AddCardTag(this.card_id, this.tag_id);

  @override
  List<Object> get props => [card_id, tag_id];
}

class UpdateTag extends TagEvent {
  final Tag updatedTag;
  const UpdateTag(this.updatedTag);

  @override
  List<Object> get props => [updatedTag];
}

class DeleteCardTag extends TagEvent {
  final int tag_id;
  final int card_id;
  const DeleteCardTag(this.tag_id, this.card_id);

  @override
  List<Object> get props => [tag_id, card_id];
}

class DeleteTag extends TagEvent {
  final int tag_id;
  const DeleteTag(this.tag_id);

  @override
  List<Object> get props => [tag_id];
}