import '../../../../core/models/ResponseModel.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';
import '../../../../core/utils/typedefs.dart';

class CommonRemoteDataSource {
  final HttpOperations _httpOps;

  CommonRemoteDataSource(this._httpOps);

  FutureResponseModel restaurantSearch({
    String? page,
    String? size,
    String? localeIsoCode,
    Map<String, dynamic>? requestBody
  }) {
    return _httpOps.postData(
      endPoint: restaurantSearchEndPoint,
      params: "?page=$page&size=$size&localeIsoCode=$localeIsoCode",
      data: requestBody,
    );
  }
}
