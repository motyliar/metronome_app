enum Meter {
  threeFour(count: 3, meter: 4),
  fourFour(count: 4, meter: 4),
  fiveFour(count: 5, meter: 4),
  ;

  final int count;
  final int meter;
  const Meter({required this.count, required this.meter});
}
