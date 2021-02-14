import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_flashcards/bloc/tags/tags.dart';
import 'package:flutter_flashcards/data/tag_provider.dart';
import 'package:flutter_flashcards/models/tag.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final TagProvider tagProvider;

  TagBloc(this.tagProvider) : super(TagInitial());

  @override
  Stream<TagState> mapEventToState(TagEvent event) async* {
    yield TagsLoading();
    if(event is GetCardTags) {
      yield* _reloadCardTags(event.card_id);
    } else if(event is GetDeckTags) {
      yield* _reloadDeckTags(event.deck_id);
    } else if(event is AddCardTag) {
      await tagProvider.insertCard(event.tag_id, event.card_id);
      yield* _reloadCardTags(event.card_id);
    } else if(event is AddDeckTag) {
      int tag_id = await tagProvider.insert(event.newTag);
      yield TagCreated(tag_id);
      yield* _reloadDeckTags(event.newTag.deck_id);
    } else if(event is UpdateTag) {
      await tagProvider.update(event.updatedTag);
    } else if(event is DeleteTag) {
      await tagProvider.delete(event.tag_id);
    }
  }

  Stream<TagState> _reloadCardTags(card_id) async* {
    final List<Tag> tags = await tagProvider.getTagsFromCard(card_id);
    yield TagsLoaded(tags);
  }

  Stream<TagState> _reloadDeckTags(deck_id) async* {
    final List<Tag> tags = await tagProvider.getTags(deck_id);
    yield TagsLoaded(tags);
  }
}