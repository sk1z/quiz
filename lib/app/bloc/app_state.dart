part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({required this.internetConnection, this.url});

  final bool internetConnection;
  final String? url;

  @override
  List<Object?> get props => [internetConnection, url];
}
