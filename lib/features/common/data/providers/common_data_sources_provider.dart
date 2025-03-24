
import 'package:flutter_base/core/providers/http_provider.dart';
import 'package:flutter_base/features/common/data/data_sources/common_data_sources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonDataSourcesProvider = Provider<CommonRemoteDataSource>((ref){
  return CommonRemoteDataSource(ref.read(httpOperationsProvider));
});