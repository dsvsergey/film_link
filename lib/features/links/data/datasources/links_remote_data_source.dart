import 'package:film_link/core/error/exceptions.dart' as app_exceptions;
import 'package:film_link/features/links/data/models/directory_model.dart';
import 'package:film_link/features/links/data/models/link_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source for links
abstract class LinksRemoteDataSource {
  Future<List<LinkModel>> getLinks();
  Future<List<LinkModel>> getArchivedLinks();
  Future<LinkModel> getLinkById(int id);
  Future<LinkModel> createLink({
    required String url,
    String? title,
    String? description,
    List<String>? tags,
  });
  Future<LinkModel> updateLink({
    required int id,
    String? url,
    String? title,
    String? description,
    List<String>? tags,
    bool? isArchived,
  });
  Future<void> deleteLink(int id);
  Future<List<LinkModel>> searchLinks(String query);
  Future<List<LinkModel>> getLinksByDirectoryId(int directoryId);
  Future<List<DirectoryModel>> getDirectories();
  Future<DirectoryModel> getDirectoryById(int id);
  Future<DirectoryModel> createDirectory({required DirectoryModel directory});
  Future<DirectoryModel> updateDirectory({
    required int id,
    required String name,
  });
  Future<void> deleteDirectory(int id);
  Future<List<DirectoryModel>> searchDirectories(String query);
  Future<List<DirectoryModel>> getDirectoriesByUserId();
}

/// Implementation of LinksRemoteDataSource using Supabase
class LinksRemoteDataSourceImpl implements LinksRemoteDataSource {
  final SupabaseClient supabaseClient;
  static const String _tableNameLink = 'link';
  static const String _tableNameDirectory = 'directory';

  LinksRemoteDataSourceImpl({required this.supabaseClient});

  String get _userId {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw const app_exceptions.AuthException('User not authenticated');
    }
    return user.id;
  }

  @override
  Future<List<LinkModel>> getLinks() async {
    try {
      final response = await supabaseClient
          .from(_tableNameLink)
          .select()
          .eq('user_id', _userId)
          .eq('is_archived', false)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => LinkModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to get links: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<LinkModel>> getArchivedLinks() async {
    try {
      final response = await supabaseClient
          .from(_tableNameLink)
          .select()
          .eq('user_id', _userId)
          .eq('is_archived', true)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => LinkModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to get archived links: ${e.toString()}',
      );
    }
  }

  @override
  Future<LinkModel> getLinkById(int id) async {
    try {
      final response = await supabaseClient
          .from(_tableNameLink)
          .select()
          .eq('id', id)
          .eq('user_id', _userId)
          .single();

      return LinkModel.fromJson(response);
    } catch (e) {
      throw app_exceptions.NotFoundException('Link not found: ${e.toString()}');
    }
  }

  @override
  Future<LinkModel> createLink({
    required String url,
    String? title,
    String? description,
    List<String>? tags,
  }) async {
    try {
      final now = DateTime.now();
      final data = {
        'user_id': _userId,
        'url': url,
        'title': title,
        'description': description,
        'tags': tags ?? [],
        'is_archived': false,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      final response = await supabaseClient
          .from(_tableNameLink)
          .insert(data)
          .select()
          .single();

      return LinkModel.fromJson(response);
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to create link: ${e.toString()}',
      );
    }
  }

  @override
  Future<LinkModel> updateLink({
    required int id,
    String? url,
    String? title,
    String? description,
    List<String>? tags,
    bool? isArchived,
  }) async {
    try {
      final data = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (url != null) data['url'] = url;
      if (title != null) data['title'] = title;
      if (description != null) data['description'] = description;
      if (tags != null) data['tags'] = tags;
      if (isArchived != null) data['is_archived'] = isArchived;

      final response = await supabaseClient
          .from(_tableNameLink)
          .update(data)
          .eq('id', id)
          .eq('user_id', _userId)
          .select()
          .single();

      return LinkModel.fromJson(response);
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to update link: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteLink(int id) async {
    try {
      await supabaseClient
          .from(_tableNameLink)
          .delete()
          .eq('id', id)
          .eq('user_id', _userId);
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to delete link: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<LinkModel>> searchLinks(String query) async {
    try {
      final response = await supabaseClient
          .from(_tableNameLink)
          .select()
          .eq('user_id', _userId)
          .or(
            'title.ilike.%$query%,description.ilike.%$query%,url.ilike.%$query%',
          )
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => LinkModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to search links: ${e.toString()}',
      );
    }
  }

  @override
  Future<DirectoryModel> createDirectory({
    required DirectoryModel directory,
  }) async {
    try {
      final response = await supabaseClient
          .from(_tableNameDirectory)
          .insert(directory.toJson())
          .select()
          .single();
      return DirectoryModel.fromJson(response);
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to create directory: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteDirectory(int id) async {
    try {
      await supabaseClient
          .from(_tableNameDirectory)
          .delete()
          .eq('id', id)
          .eq('user_id', _userId);
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to delete directory: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<DirectoryModel>> getDirectories() async {
    try {
      final response = await supabaseClient
          .from(_tableNameDirectory)
          .select()
          .eq('user_id', _userId);
      return (response as List)
          .map((json) => DirectoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to get directories: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<DirectoryModel>> getDirectoriesByUserId() async {
    try {
      final response = await supabaseClient
          .from(_tableNameDirectory)
          .select()
          .eq('user_id', _userId);
      return (response as List)
          .map((json) => DirectoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to get directories by user id: ${e.toString()}',
      );
    }
  }

  @override
  Future<DirectoryModel> getDirectoryById(int id) async {
    try {
      final response = await supabaseClient
          .from(_tableNameDirectory)
          .select()
          .eq('id', id)
          .eq('user_id', _userId)
          .single();
      return DirectoryModel.fromJson(response);
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to get directory by id: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<LinkModel>> getLinksByDirectoryId(int directoryId) async {
    try {
      final response = await supabaseClient
          .from(_tableNameLink)
          .select()
          .eq('directory_id', directoryId)
          .eq('user_id', _userId);
      return (response as List)
          .map((json) => LinkModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to get links by directory id: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<DirectoryModel>> searchDirectories(String query) async {
    try {
      final response = await supabaseClient
          .from(_tableNameDirectory)
          .select()
          .eq('user_id', _userId)
          .or(
            'name.ilike.%$query%,description.ilike.%$query%,url.ilike.%$query%',
          )
          .order('created_at', ascending: false);
      return (response as List)
          .map((json) => DirectoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to search directories: ${e.toString()}',
      );
    }
  }

  @override
  Future<DirectoryModel> updateDirectory({
    required int id,
    required String name,
  }) async {
    try {
      final response = await supabaseClient
          .from(_tableNameDirectory)
          .update({'name': name})
          .eq('id', id)
          .eq('user_id', _userId)
          .select()
          .single();
      return DirectoryModel.fromJson(response);
    } catch (e) {
      throw app_exceptions.ServerException(
        'Failed to update directory: ${e.toString()}',
      );
    }
  }
}
