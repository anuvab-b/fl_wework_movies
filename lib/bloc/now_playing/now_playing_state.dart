part of 'now_playing_bloc.dart';

class NowPlayingState {
  final List<NowPlaying> nowPlayingList;
  final bool nowPlayingError;
  final bool nowPlayingLoading;

  NowPlayingState({
    required this.nowPlayingLoading,
    required this.nowPlayingList,
    required this.nowPlayingError,
  });

  NowPlayingState copyWith(List<NowPlaying> nowPlaying,
      bool nowPlayingError, bool nowPlayingLoading) {
    return NowPlayingState(
      nowPlayingLoading: nowPlayingLoading,
      nowPlayingList: nowPlaying,
      nowPlayingError: nowPlayingError,
    );
  }
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial({
    required super.nowPlayingLoading,
    required super.nowPlayingList,
    required super.nowPlayingError,
  });
}

class NowPlayingError extends NowPlayingState {
  String errorMessage;

  NowPlayingError({
    required this.errorMessage,
    required super.nowPlayingLoading,
    required super.nowPlayingList,
    required super.nowPlayingError,
  });
}

class NowPlayingLoading extends NowPlayingState {
  NowPlayingLoading({
    required super.nowPlayingLoading,
    required super.nowPlayingList,
    required super.nowPlayingError,
  });
}

class NowPlayingSuccess extends NowPlayingState {
  NowPlayingSuccess({
    required super.nowPlayingLoading,
    required super.nowPlayingList,
    required super.nowPlayingError,
  });
}