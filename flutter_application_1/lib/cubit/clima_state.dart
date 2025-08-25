part of 'clima_cubit.dart';

abstract class ClimaState {}

class Initial extends ClimaState {}

class Loading extends ClimaState {}

class Loaded extends ClimaState {
  final List<dynamic> posts;

  Loaded(this.posts);
}

class Error extends ClimaState {
  final String message;

  Error(this.message);
}

class Post {
  final String title;
  final String body;

  Post({required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(title: json['title'] ?? '', body: json['body'] ?? '');
  }
}
