import 'package:snood/core/models/experance_model.dart';
import 'package:snood/core/models/get_country_model.dart';
import 'package:snood/core/models/religions_model.dart';
import 'package:snood/core/utils/dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/get_occupations_model.dart';
import '../../../core/models/insert_mediation_request_model.dart';
import '../../../core/remote/service.dart';
import 'state.dart';

class InsertMediationCubit extends Cubit<InsertMediationState> {
  InsertMediationCubit(this.api) : super(MediatationInitial());
  ServiceApi api;
  InsertMediationRequestModel? insertMediationRequestModel;
  ExperanceModel? experanceModel;
  ReligionsModel? religionsModel;
  String? selectedExperience;
  String? selectedReligion;
  String? visaNo;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void getReligionsData() async {
    emit(GetReligionsLoadingState());
    final result = await api.getReligionsApi();
    result.fold(
          (failure) {
        emit(GetReligionsErrorState('Error loading data: $failure'));
      },
          (r) {
            religionsModel = r;
        emit(GetReligionsLoadedState());
      },
    );
  }
  void getExperiencesData() async {
    emit(GetExperiencesLoadingState());
    final result = await api.getExperianceApi();
    result.fold(
          (failure) {
        emit(GetExperiencesErrorState('Error loading data: $failure'));
      },
          (r) {
        experanceModel = r;
        emit(GetExperiencesLoadedState());
      },
    );
  }
  GetOccupationsModel?  occupationsModel;
  void getOccupationsData({required String clientId}) async {

    emit(GetOccupationsLoadingState());
    final result = await api.getGetOccupationsApi(clientId: clientId);
    result.fold(
          (failure) {
        emit(GetOccupationsErrorState('Error loading data: $failure'));
      },
          (r) {
        occupationsModel = r;
        emit(GetOccupationsLoadedState());
      },
    );
  }
  GetCountriesModel?  getCountriesModel;
  void getCountryData() async {

    emit(GetCountrysLoadingState());
    final result = await api.getCountryApi();
    result.fold(
          (failure) {
        emit(GetCountrysErrorState('Error loading data: $failure'));
      },
          (r) {
            getCountriesModel = r;
        emit(GetCountrysLoadedState());
      },
    );
  }
  void insertMediationRequestData({required BuildContext context,required String countryId, required int occId}) async {
    emit(GetMediatationLoadingState());
    final result = await api.insertMediationRequestApi(
        countryId: countryId,
        occId: occId,
        experince: selectedExperience.toString(),
        religion: selectedReligion.toString(),
        visaNo: visaNo.toString());
    result.fold(
      (failure) {
        emit(GetMediatationErrorState('Error loading data: $failure'));
      },
      (r) {
        insertMediationRequestModel = r;
        successGetBar("insert_mediatation_data_success".tr());
        Navigator.pop(context);
        emit(GetMediatationLoadedState());
      },
    );
  }
}
