class Repository{
  String name;
  String description;
  String githubUrl;
  String dateCreated;
  List<String> languages;
  String stars;

  Repository({required this.name, required this.description, required this.githubUrl, required this.dateCreated, required this.languages, required this.stars});
}