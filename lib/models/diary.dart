class Diary {
  late String id;
  late String mood;
  late String sleep;
  late String food;
  late String water;
  late String exercise;
  late String? note;
  late int moodScore;
  late dynamic dateTime;
  late bool status;

  Diary({
    this.id = '',
    this.mood = '',
    this.sleep = '',
    this.food = '',
    this.water = '',
    this.exercise = '',
    this.note = '',
    this.moodScore = 0,
    this.dateTime,
    this.status = true,
  });

  factory Diary.fromJson(dynamic json) {
    // print(json['dateTime'].toDate());
    return Diary(
      id: json['id'] ?? '',
      mood: json['mood'] ?? '',
      sleep: json['sleep'] ?? '',
      food: json['food'] ?? '',
      water: json['water'] ?? '',
      exercise: json['exercise'] ?? '',
      // note: json['note'] ?? '',
      moodScore: json['moodScore'] ?? 0,
      dateTime: json['dateTime'].toDate(),
      status: json['status'] ?? true,
    );
  }

  static fromMap(data) {}
}
