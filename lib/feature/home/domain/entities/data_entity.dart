import 'package:kujitoon/feature/home/domain/entities/last_read_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/list_last_update_commic.dart';
import 'package:kujitoon/feature/home/domain/entities/list_prominent_commic.dart';

class DataEntity {
  final LastReadCommic? lastReadCommic;
  final ListProminentCommic listProminentCommic;
  final ListLastUpdateCommic listLastUpdateCommic;

  DataEntity({
    required this.lastReadCommic,
    required this.listProminentCommic,
    required this.listLastUpdateCommic,
  });
}