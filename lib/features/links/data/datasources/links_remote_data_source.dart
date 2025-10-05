import 'package:film_link/core/error/exceptions.dart' as app_exceptions;
import 'package:film_link/features/links/data/models/link_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Remote data source for links
abstract class LinksRemoteDataSource {
  Future<List<LinkModel>> getLinks();
  Future<List<LinkModel>> getArchivedLinks();
  Future<LinkModel> getLinkById(String id);
  Future<LinkModel> createLink({
    required String url,
    String? title,
    String? description,
    List<String>? tags,
  });
  Future<LinkModel> updateLink({
    required String id,
    String? url,
    String? title,
    String? description,
    List<String>? tags,
    bool? isArchived,
  });
  Future<void> deleteLink(String id);
  Future<List<LinkModel>> searchLinks(String query);
}

/// Implementation of LinksRemoteDataSource using Supabase
class LinksRemoteDataSourceImpl implements LinksRemoteDataSource {
  final SupabaseClient supabaseClient;
  static const String _tableName = 'links';
  
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
          .from(_tableName)
          .select()
          .eq('user_id', _userId)
          .eq('is_archived', false)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((json) => LinkModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException('Failed to get links: ${e.toString()}');
    }
  }
  
  @override
  Future<List<LinkModel>> getArchivedLinks() async {
    try {
      final response = await supabaseClient
          .from(_tableName)
          .select()
          .eq('user_id', _userId)
          .eq('is_archived', true)
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((json) => LinkModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException('Failed to get archived links: ${e.toString()}');
    }
  }
  
  @override
  Future<LinkModel> getLinkById(String id) async {
    try {
      final response = await supabaseClient
          .from(_tableName)
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
          .from(_tableName)
          .insert(data)
          .select()
          .single();
      
      return LinkModel.fromJson(response);
    } catch (e) {
      throw app_exceptions.ServerException('Failed to create link: ${e.toString()}');
    }
  }
  
  @override
  Future<LinkModel> updateLink({
    required String id,
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
          .from(_tableName)
          .update(data)
          .eq('id', id)
          .eq('user_id', _userId)
          .select()
          .single();
      
      return LinkModel.fromJson(response);
    } catch (e) {
      throw app_exceptions.ServerException('Failed to update link: ${e.toString()}');
    }
  }
  
  @override
  Future<void> deleteLink(String id) async {
    try {
      await supabaseClient
          .from(_tableName)
          .delete()
          .eq('id', id)
          .eq('user_id', _userId);
    } catch (e) {
      throw app_exceptions.ServerException('Failed to delete link: ${e.toString()}');
    }
  }
  
  @override
  Future<List<LinkModel>> searchLinks(String query) async {
    try {
      final response = await supabaseClient
          .from(_tableName)
          .select()
          .eq('user_id', _userId)
          .or('title.ilike.%$query%,description.ilike.%$query%,url.ilike.%$query%')
          .order('created_at', ascending: false);
      
      return (response as List)
          .map((json) => LinkModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw app_exceptions.ServerException('Failed to search links: ${e.toString()}');
    }
  }
}
