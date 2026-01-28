import 'package:kujitoon/core/model/prominent_commic_dto.dart';

class AllCommicDto {
  final List<ProminentCommicDto> _listProminentCommics;
  final int _pageSize;
  final int _totalPages;
  final int _currentPage;

  AllCommicDto({
    required List<ProminentCommicDto> listProminentCommics,
    required int pageSize,
    required int totalPages,
    required int currentPage,
  })  : _listProminentCommics = listProminentCommics,
        _pageSize = pageSize,
        _totalPages = totalPages,
        _currentPage = currentPage;

  List<ProminentCommicDto> get listProminentCommics => _listProminentCommics;
  int get pageSize => _pageSize;
  int get totalPages => _totalPages;
  int get currentPage => _currentPage;

}