import 'package:flutter/cupertino.dart';
import 'ResponseModel.dart';

typedef OnLoading = Widget Function(StateModel);
typedef OnSuccess<T> = Widget Function(StateModel<T>);
typedef OnFailure = Widget Function(StateModel);
typedef OnInitial = Widget Function(StateModel);

typedef OnLoading1 = Function(StateModel);
typedef OnSuccess1<T> = Function(StateModel<T>);
typedef OnEmpty<T> = Function(StateModel<T>);
typedef OnFailure1 = Function(StateModel);
typedef OnInitial1 = Function(StateModel);

class StateModel<T> {
  final DataState state;
  final T? data;
  final String? message;
  final List<String>? errors;
  PaginationModel? pagination;

  StateModel({
    this.state = DataState.INITIAL,
    this.data,
    this.message,
    this.errors,
    this.pagination,
  });
  @override
  String toString() {
    return "State -> $state , Data : $data ";
  }

  factory StateModel.loading() {
    return StateModel(state: DataState.LOADING);
  }

  factory StateModel.paginate(data) {
    return StateModel(state: DataState.MORE_LOADING, data: data);
  }

  factory StateModel.success(dynamic data,{PaginationModel? paginationModel,String? message}) {
    return StateModel(state: DataState.SUCCESS, data: data, message: message,pagination: paginationModel);
  }

  factory StateModel.fail(String message, List<String> errors) {
    return StateModel(state: DataState.ERROR, message: message, errors: errors);
  }

  factory StateModel.empty({dynamic data}) {
    return StateModel(state: DataState.EMPTY, data: data);
  }
}

enum DataState {
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR,
  EMPTY,
  MORE_LOADING,
  MORE_LOADED,
}

extension StateHandel on StateModel {
  Widget handelState<T>(
      {OnLoading? onLoading, OnSuccess? onSuccess, OnFailure? onFailure}) {
    switch (state) {
      case DataState.LOADING:
        return onLoading!(this);
      case DataState.SUCCESS:
        return onSuccess!(this);
        break;
      case DataState.ERROR:
        return onFailure!(this);
        break;
      case DataState.EMPTY:
        return onFailure!(this);
        break;
      case DataState.MORE_LOADING:
        return onSuccess!(this);
        break;
      case DataState.MORE_LOADED:
        return onSuccess!(this);
        break;
      case DataState.INITIAL:
        break;
    }
    return onSuccess!(this);
  }

  void handelStateWithoutWidget(
      {OnLoading1? onLoading,
      OnSuccess1? onSuccess,
      OnFailure1? onFailure,
      OnEmpty? onEmpty}) {
    switch (state) {
      case DataState.LOADING:
        return onLoading!(this);
      case DataState.SUCCESS:
        return onSuccess!(this);
        break;
      case DataState.ERROR:
        return onFailure!(this);
        break;
      case DataState.EMPTY:
        return onEmpty!(this);
        break;
      case DataState.MORE_LOADING:
        return onSuccess!(this);
        break;
      case DataState.MORE_LOADED:
        return onSuccess!(this);
        break;
      case DataState.INITIAL:
        return;
    }
    return onLoading!(this);
  }
}

extension ResponseToStateModel on ResponseModel {
  StateModel toState() {
    return StateModel(
        data: data,
        state: code == 200 ? DataState.SUCCESS : DataState.ERROR,
        message: message);
  }
}
