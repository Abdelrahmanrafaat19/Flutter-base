
import '../../../../core/providers/http_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_sources/data_sources.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final httpOps = ref.read(httpOperationsProvider); // HttpOps Provider
  return AuthRemoteDataSource(httpOps);
});
