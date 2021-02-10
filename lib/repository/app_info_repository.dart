import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Almaz/api/common/ps_resource.dart';
import 'package:Almaz/api/common/ps_status.dart';
import 'package:Almaz/api/ps_api_service.dart';
import 'package:Almaz/repository/Common/ps_repository.dart';
import 'package:Almaz/viewobject/ps_app_info.dart';

class AppInfoRepository extends PsRepository {
  AppInfoRepository({
    @required PsApiService psApiService,
  }) {
    _psApiService = psApiService;
  }
  PsApiService _psApiService;

  Future<PsResource<PSAppInfo>> postDeleteHistory(Map<dynamic, dynamic> jsonMap,
      {bool isLoadFromServer = true}) async {
    final PsResource<PSAppInfo> _resource =
        await _psApiService.postPsAppInfo(jsonMap);
    if (_resource.status == PsStatus.SUCCESS) {
      if (_resource.data.deleteObject.isNotEmpty) {}
      return _resource;
    } else {
      final Completer<PsResource<PSAppInfo>> completer =
          Completer<PsResource<PSAppInfo>>();
      completer.complete(_resource);
      return completer.future;
    }
  }
}
