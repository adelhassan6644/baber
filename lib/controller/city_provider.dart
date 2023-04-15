import 'package:baber/navigation/custom_navigation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/core/error/failures.dart';
import '../app/core/error/api_error_handler.dart';
import '../app/core/utils/app_snack_bar.dart';
import '../app/core/utils/color_resources.dart';
import '../data/model/City_model.dart';
import '../domain/repository/city_repo.dart';
import '../navigation/routes.dart';
import 'firebase_auth_provider.dart';

class CityProvider extends ChangeNotifier {
  final CityRepo cityRepo;
  CityProvider({
    required this.cityRepo,
  });

  City? city;
  CityModel? cityModel;

  void onSelectCity({required City location}) {
    city = location;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  getCities() async {
    try {
      {
        cityModel?.cities?.clear();
        notifyListeners();
        Either<ServerFailure, Response> response = await cityRepo.getCities();
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: ApiErrorHandler.getMessage(fail.error),
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
          notifyListeners();
        }, (success) {
          cityModel = CityModel.fromJson(success.data);
          notifyListeners();
        });
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  setCity() async {
    try {
        if (Provider.of<FirebaseAuthProvider>(CustomNavigator.navigatorState.currentContext!, listen: false).isLogin) {
          _isLoading = true;
          notifyListeners();
          Either<ServerFailure, Response> response =
          await cityRepo.setCity(cityId: city!.id!);
          response.fold((fail) {
            _isLoading = false;
            CustomSnackBar.showSnackBar(
                notification: AppNotification(
                    message: ApiErrorHandler.getMessage(fail.error),
                    isFloating: true,
                    backgroundColor: ColorResources.IN_ACTIVE,
                    borderColor: Colors.transparent));
            notifyListeners();
          }, (success) async {
            saveYourCity();
            getYourCity();
            CustomNavigator.push(Routes.DASHBOARD, replace: true);
            _isLoading = false;
            notifyListeners();
          });
        } else{
          saveYourCity();
          getYourCity();
          CustomNavigator.push(Routes.DASHBOARD,replace: true);
        }

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

  getYourCity() {
    city?.name = cityRepo.getCityName();
    notifyListeners();
  }

  saveYourCity() {
    cityRepo.saveCity(cityId: city!.id.toString(),cityName: city!.name??"");
    notifyListeners();
  }
}
