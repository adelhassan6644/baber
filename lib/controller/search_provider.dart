import 'package:baber/domain/repository/search_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/core/error/api_error_handler.dart';
import '../app/core/error/failures.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/search_model.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepo searchRepo;
  SearchProvider({required this.searchRepo});

  late int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex({
    required int index,
  }) {
    _currentIndex = index;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

   SearchModel? searchResult;

  getSearchResult({required String q}) async {
    try {
      _isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await searchRepo.getSearchResult(query: q);
      response.fold((fail) {
        _isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail.error),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        _isLoading = false;
        searchResult = SearchModel.fromJson(success.data["data"]);
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isLoading = false;
      notifyListeners();
    }
  }



}
