class TimeSlot {
  final DateTime startsAt;
  final DateTime endsAt;

  TimeSlot({required this.startsAt, required this.endsAt}) {
    if (!endsAt.isAfter(startsAt)) {
      throw ArgumentError('endsAt must be after startsAt');
    }
  }
}
