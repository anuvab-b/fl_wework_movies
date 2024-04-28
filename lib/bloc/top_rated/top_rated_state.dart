part of 'top_rated_bloc.dart';

class TopRatedState {
  final List<MovieListModel> topRatedList;
  final bool topRatedError;
  final bool topRatedLoading;

  TopRatedState({
    required this.topRatedLoading,
    required this.topRatedList,
    required this.topRatedError,
  });

  TopRatedState copyWith(List<MovieListModel> topRatedPlaying,
      bool topRatedError, bool topRatedLoading) {
    return TopRatedState(
      topRatedLoading: topRatedLoading,
      topRatedList: topRatedPlaying,
      topRatedError: topRatedError,
    );
  }
}

class TopRatedInitial extends TopRatedState {
  TopRatedInitial({
    required super.topRatedLoading,
    required super.topRatedList,
    required super.topRatedError,
  });
}

class TopRatedError extends TopRatedState {
  String errorMessage;

  TopRatedError({
    required this.errorMessage,
    required super.topRatedLoading,
    required super.topRatedList,
    required super.topRatedError,
  });
}

class TopRatedLoading extends TopRatedState {
  TopRatedLoading({
    required super.topRatedLoading,
    required super.topRatedList,
    required super.topRatedError,
  });
}

class TopRatedSuccess extends TopRatedState {
  TopRatedSuccess({
    required super.topRatedLoading,
    required super.topRatedList,
    required super.topRatedError,
  });
}
