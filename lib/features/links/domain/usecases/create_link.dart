import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/entities/link_entity.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

/// Use case for creating a new link
class CreateLink implements UseCase<LinkEntity, CreateLinkParams> {
  final LinksRepository repository;
  
  CreateLink(this.repository);
  
  @override
  Future<Either<Failure, LinkEntity>> call(CreateLinkParams params) async {
    return await repository.createLink(
      url: params.url,
      title: params.title,
      description: params.description,
      tags: params.tags,
    );
  }
}

class CreateLinkParams extends Equatable {
  final String url;
  final String? title;
  final String? description;
  final List<String>? tags;
  
  const CreateLinkParams({
    required this.url,
    this.title,
    this.description,
    this.tags,
  });
  
  @override
  List<Object?> get props => [url, title, description, tags];
}
