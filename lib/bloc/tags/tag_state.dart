import 'package:equatable/equatable.dart';
import 'package:flutter_flashcards/models/tag.dart';

///Possible States the UI can be in
abstract class TagState extends Equatable {
  const TagState();
}

class TagInitial extends TagState {
  const TagInitial();

  @override
  List<Object> get props => [];
}

class TagCreated extends TagState {
  final int tag_id;
  const TagCreated(this.tag_id);

  @override
  List<Object> get props => [tag_id];
}

class TagsLoading extends TagState {
  const TagsLoading();

  @override
  List<Object> get props => [];
}

class TagsLoaded extends TagState {
  final List<Tag> tags;
  const TagsLoaded(this.tags);

  @override
  List<Object> get props => [tags];
}

class TagLoaded extends TagState {
  final Tag tag;
  const TagLoaded(this.tag);

  @override
  List<Object> get props => [tag];
}


class TagError extends TagState {
  final String message;
  const TagError(this.message);

  @override
  List<Object> get props => [message];

}