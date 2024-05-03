part of 'now_playing_bloc.dart';

class NowPlayingEvent {}
class OnNowPlayingInit extends NowPlayingEvent{
  final bool refresh;
  OnNowPlayingInit({required this.refresh});
}
class OnSearchMovieTextChange extends NowPlayingEvent{
  final String text;
  OnSearchMovieTextChange({required this.text});
}