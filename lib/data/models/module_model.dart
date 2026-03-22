class ModuleModel {
  final String id;
  final String title;
  final String description;
  final String? icon;
  final List<String> highlights;
  final bool isCompleted;

  ModuleModel({
    required this.id,
    required this.title,
    required this.description,
    this.icon,
    this.highlights = const [],
    this.isCompleted = false,
  });
}
