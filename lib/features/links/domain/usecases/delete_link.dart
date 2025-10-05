import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:film_link/core/error/failures.dart';
import 'package:film_link/core/usecases/usecase.dart';
import 'package:film_link/features/links/domain/repositories/links_repository.dart';

/// Use case for deleting a link
class DeleteLink implements UseCase<void, DeleteLinkParams> {
  final LinksRepository repository;

  DeleteLink(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteLinkParams params) async {
    return await repository.deleteLink(params.id);
  }
}

class DeleteLinkParams extends Equatable {
  final int id;

  const DeleteLinkParams(this.id);

  @override
  List<Object?> get props => [id];
}
