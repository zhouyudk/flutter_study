class PlankRecord {
  int startTime; // time stamp millisecond
  int duration; // second
  PlankRecord({required this.startTime, required this.duration});

  factory PlankRecord.fromJson(Map<String, dynamic> parsedJson) {
    return PlankRecord(
      startTime: parsedJson['start_time'],
      duration: parsedJson['duration'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'start_time': startTime,
      'duration': duration,
    };
  }
}