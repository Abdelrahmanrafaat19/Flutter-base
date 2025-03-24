import 'package:flutter_base/features/home/data/data_sources/data_sources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/http_provider.dart';

final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
  final httpOps = ref.read(httpOperationsProvider); // HttpOps Provider
  return HomeRemoteDataSource(httpOps);
});
