class Task {
  const Task({
    required this.name,
    this.rating,
    this.description,
    this.wouldDoAgain,
  });

  final String name;
  final int? rating;
  final String? description;
  final bool? wouldDoAgain;

  String abbrev() {
    return name.isNotEmpty ? name.substring(0, 1) : '';
  }

  Task update({
    int? rating,
    String? description,
    bool? wouldDoAgain,
  }) {
    return Task(
      name: name,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      wouldDoAgain: wouldDoAgain ?? this.wouldDoAgain,
    );
  }
}
