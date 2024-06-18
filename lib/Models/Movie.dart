class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final String? releaseDate;
  final String? originalLanguage;
  final String? originalTitle;
  final double? voteCount;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      this.originalLanguage,
      this.releaseDate,
      this.originalTitle,
      this.voteCount});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      title: json["title"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"].toDouble(),
      originalLanguage: json["original_language"],
      releaseDate: json["release_date"],
      originalTitle: json["original_title"],
      voteCount: json["vote_count"].toDouble(),
    );
  }
}
