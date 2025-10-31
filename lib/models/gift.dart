class Gift {
  const Gift({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.goalAmount,
    required this.raisedAmount,
    required this.occasion,
    required this.organizer,
    required this.contributors,
    required this.description,
  });

  final String id;
  final String title;
  final String imageUrl;
  final double goalAmount;
  final double raisedAmount;
  final String occasion;
  final String organizer;
  final List<Contributor> contributors;
  final String description;

  double get progress => raisedAmount / goalAmount;
}

class Contributor {
  const Contributor({
    required this.name,
    required this.avatarUrl,
    this.message,
  });

  final String name;
  final String avatarUrl;
  final String? message;
}
