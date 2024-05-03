part of 'top_rated_bloc.dart';

class TopRatedState {
  final List<TopRated> allTopRatedList;
  final List<TopRated> filterTopRatedList;
  final bool topRatedError;
  final bool topRatedLoading;

  TopRatedState({
    required this.topRatedLoading,
    required this.allTopRatedList,
    required this.filterTopRatedList,
    required this.topRatedError,
  });

  TopRatedState copyWith(List<TopRated> topRatedPlaying,
      bool topRatedError, bool topRatedLoading) {
    return TopRatedState(
      topRatedLoading: topRatedLoading,
      allTopRatedList: allTopRatedList,
      filterTopRatedList: topRatedPlaying,
      topRatedError: topRatedError,
    );
  }
}

class TopRatedInitial extends TopRatedState {
  TopRatedInitial({
    required super.topRatedLoading,
    required super.filterTopRatedList,
    required super.allTopRatedList,
    required super.topRatedError,
  });
}

class TopRatedError extends TopRatedState {
  String errorMessage;

  TopRatedError({
    required this.errorMessage,
    required super.topRatedLoading,
    required super.allTopRatedList,
    required super.filterTopRatedList,
    required super.topRatedError,
  });
}

class TopRatedLoading extends TopRatedState {
  TopRatedLoading({
    required super.topRatedLoading,
    required super.filterTopRatedList,
    required super.allTopRatedList,
    required super.topRatedError,
  });
}

class TopRatedSuccess extends TopRatedState {
  TopRatedSuccess({
    required super.topRatedLoading,
    required super.allTopRatedList,
    required super.filterTopRatedList,
    required super.topRatedError,
  });
}
