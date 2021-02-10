import 'dart:async';

import 'package:Almaz/api/common/ps_resource.dart';
import 'package:Almaz/api/common/ps_status.dart';
import 'package:Almaz/provider/common/ps_provider.dart';
import 'package:Almaz/repository/product_repository.dart';
import 'package:Almaz/utils/utils.dart';
import 'package:Almaz/viewobject/api_status.dart';
import 'package:Almaz/viewobject/common/ps_value_holder.dart';
import 'package:flutter/cupertino.dart';

class TouchCountProvider extends PsProvider {
  TouchCountProvider(
      {@required ProductRepository repo,
      @required this.psValueHolder,
      int limit = 0})
      : super(repo, limit) {
    _repo = repo;

    print('TouchCount Product Provider: $hashCode');

    Utils.checkInternetConnectivity().then((bool onValue) {
      isConnectedToInternet = onValue;
    });
  }

  ProductRepository _repo;
  PsValueHolder psValueHolder;

  PsResource<ApiStatus> _apiStatus =
      PsResource<ApiStatus>(PsStatus.NOACTION, '', null);
  PsResource<ApiStatus> get user => _apiStatus;

  @override
  void dispose() {
    isDispose = true;
    print('TouchCount Product Provider Dispose: $hashCode');
    super.dispose();
  }

  Future<dynamic> postTouchCount(
    Map<dynamic, dynamic> jsonMap,
  ) async {
    isLoading = true;

    isConnectedToInternet = await Utils.checkInternetConnectivity();

    _apiStatus = await _repo.postTouchCount(
        jsonMap, isConnectedToInternet, PsStatus.PROGRESS_LOADING);

    return _apiStatus;
  }
}
