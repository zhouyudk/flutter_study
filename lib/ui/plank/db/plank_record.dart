class PlankRecord {
  int? startTime; // time stamp millisecond
  int? duration; // second
  PlankRecord({this.startTime, this.duration});

  factory PlankRecord.fromJson(Map<String, dynamic> parsedJson) {
    return PlankRecord(
      startTime: parsedJson['startTime'],
      duration: parsedJson['duration'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'duration': duration,
    };
  }
}