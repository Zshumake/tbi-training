class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String? moduleId;
  final String? difficulty; // 'basic', 'intermediate', 'board'

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.moduleId,
    this.difficulty,
  });
}
