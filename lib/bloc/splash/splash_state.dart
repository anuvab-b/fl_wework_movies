part of 'splash_bloc.dart';

abstract class SplashState{}

class SplashInit extends SplashState{}
class SplashLoading extends SplashState{}
class SplashSuccess extends SplashState{}
class SplashError extends SplashState{}