class Flashcard {
  final String front;
  final String back;
  final String? moduleId;

  const Flashcard({
    required this.front,
    required this.back,
    this.moduleId,
  });
}
