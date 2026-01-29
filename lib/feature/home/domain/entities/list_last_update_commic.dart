import 'package:kujitoon/feature/home/domain/entities/last_update_commic.dart';

class ListLastUpdateCommic {
  final List<LastUpdateCommic> listLastUpdateCommics;
  final int pageSize;
  final int totalPages;
  final int currentPage;

  ListLastUpdateCommic({required this.listLastUpdateCommics, required this.pageSize, required this.totalPages, required this.currentPage});
}