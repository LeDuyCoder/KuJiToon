import 'package:kujitoon/feature/read/domain/entities/comment_entity.dart';
import 'package:kujitoon/feature/read/domain/repositories/read_repository.dart';

class LoadCommentUsecase {
  final ReadRepository repository;

  LoadCommentUsecase({required this.repository});

  Future<List<CommentEntity>> loadAllComment(String slug) async {
    return repository.getAllCommentBySlug(slug);
  }
}