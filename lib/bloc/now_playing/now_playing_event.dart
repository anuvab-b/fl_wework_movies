part of 'now_playing_bloc.dart';

class NowPlayingEvent {}
class OnNowPlayingInit extends NowPlayingEvent{}
class OnSearchMovieTextChange extends NowPlayingEvent{
  final String text;
  OnSearchMovieTextChange({required this.text});
}