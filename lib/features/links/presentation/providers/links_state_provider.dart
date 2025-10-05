import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/link_entity.dart';
import 'package:film_link/features/links/domain/usecases/create_link.dart';
import 'package:film_link/features/links/domain/usecases/delete_link.dart';
import 'package:film_link/features/links/domain/usecases/get_links.dart';
import 'package:film_link/features/links/domain/usecases/update_link.dart';
import 'package:film_link/features/links/presentation/providers/links_providers.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'links_state_provider.freezed.dart';

@freezed
class LinksState with _$LinksState {
  const factory LinksState.initial() = _Initial;
  const factory LinksState.loading() = _Loading;
  const factory LinksState.loaded(List<LinkEntity> links) = _Loaded;
  const factory LinksState.error(String message) = _Error;
}

class LinksStateNotifier extends StateNotifier<LinksState> {
  final GetLinks _getLinks;
  final CreateLink _createLink;
  final UpdateLink _updateLink;
  final DeleteLink _deleteLink;

  LinksStateNotifier({
    required GetLinks getLinks,
    required CreateLink createLink,
    required UpdateLink updateLink,
    required DeleteLink deleteLink,
  }) : _getLinks = getLinks,
       _createLink = createLink,
       _updateLink = updateLink,
       _deleteLink = deleteLink,
       super(const LinksState.initial());

  Future<void> loadLinks() async {
    state = const LinksState.loading();

    final result = await _getLinks(const NoParams());

    result.fold(
      (failure) => state = LinksState.error(failure.message),
      (links) => state = LinksState.loaded(links),
    );
  }

  Future<void> createLink({
    required String url,
    String? title,
    String? description,
    List<String>? tags,
  }) async {
    final result = await _createLink(
      CreateLinkParams(
        url: url,
        title: title,
        description: description,
        tags: tags,
      ),
    );

    result.fold(
      (failure) => state = LinksState.error(failure.message),
      (_) => loadLinks(),
    );
  }

  Future<void> updateLink({
    required String id,
    String? url,
    String? title,
    String? description,
    List<String>? tags,
    bool? isArchived,
  }) async {
    final result = await _updateLink(
      UpdateLinkParams(
        id: id,
        url: url,
        title: title,
        description: description,
        tags: tags,
        isArchived: isArchived,
      ),
    );

    result.fold(
      (failure) => state = LinksState.error(failure.message),
      (_) => loadLinks(),
    );
  }

  Future<void> deleteLink(String id) async {
    final result = await _deleteLink(DeleteLinkParams(id));

    result.fold(
      (failure) => state = LinksState.error(failure.message),
      (_) => loadLinks(),
    );
  }
}

final linksStateProvider =
    StateNotifierProvider<LinksStateNotifier, LinksState>((ref) {
      return LinksStateNotifier(
        getLinks: ref.watch(getLinksUseCaseProvider),
        createLink: ref.watch(createLinkUseCaseProvider),
        updateLink: ref.watch(updateLinkUseCaseProvider),
        deleteLink: ref.watch(deleteLinkUseCaseProvider),
      );
    });
