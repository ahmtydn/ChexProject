class MovieModel{
  final String categoryName;
  final List<Movie>movies;
  double position=0;

  MovieModel({required this.categoryName,required this.movies});
}

class Movie{
  final String name;
  final int price;

  Movie(this.name,this.price);
}