part of 'now_playing_bloc.dart';

class NowPlayingState {
  final List<NowPlaying> allNowPlayingList;
  final List<NowPlaying> filterNowPlayingList;
  final bool nowPlayingError;
  final bool nowPlayingLoading;

  NowPlayingState({
    required this.nowPlayingLoading,
    required this.allNowPlayingList,
    required this.filterNowPlayingList,
    required this.nowPlayingError,
  });

  NowPlayingState copyWith(List<NowPlaying> nowPlaying,
      bool nowPlayingError, bool nowPlayingLoading) {
    return NowPlayingState(
      nowPlayingLoading: nowPlayingLoading,
      allNowPlayingList: allNowPlayingList,
      filterNowPlayingList: nowPlaying,
      nowPlayingError: nowPlayingError,
    );
  }
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial({
    required super.nowPlayingLoading,
    required super.allNowPlayingList,
    required super.filterNowPlayingList,
    required super.nowPlayingError,
  });
}

class NowPlayingError extends NowPlayingState {
  String errorMessage;

  NowPlayingError({
    required this.errorMessage,
    required super.nowPlayingLoading,
    required super.allNowPlayingList,
    required super.filterNowPlayingList,
    required super.nowPlayingError,
  });
}

class NowPlayingLoading extends NowPlayingState {
  NowPlayingLoading({
    required super.nowPlayingLoading,
    required super.allNowPlayingList,
    required super.filterNowPlayingList,
    required super.nowPlayingError,
  });
}

class NowPlayingSuccess extends NowPlayingState {
  NowPlayingSuccess({
    required super.nowPlayingLoading,
    required super.allNowPlayingList,
    required super.filterNowPlayingList,
    required super.nowPlayingError,
  });
}