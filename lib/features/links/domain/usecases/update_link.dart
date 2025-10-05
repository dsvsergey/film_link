import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/link_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

/// Use case for updating a link
class UpdateLink implements UseCase<LinkEntity, UpdateLinkParams> {
  final LinksRepository repository;
  
  UpdateLink(this.repository);
  
  @override
  Future<Either<Failure, LinkEntity>> call(UpdateLinkParams params) async {
    return await repository.updateLink(
      id: params.id,
      url: params.url,
      title: params.title,
      description: params.description,
      tags: params.tags,
      isArchived: params.isArchived,
    );
  }
}

class UpdateLinkParams extends Equatable {
  final String id;
  final String? url;
  final String? title;
  final String? description;
  final List<String>? tags;
  final bool? isArchived;
  
  const UpdateLinkParams({
    required this.id,
    this.url,
    this.title,
    this.description,
    this.tags,
    this.isArchived,
  });
  
  @override
  List<Object?> get props => [id, url, title, description, tags, isArchived];
}
