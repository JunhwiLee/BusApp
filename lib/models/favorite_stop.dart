class FavoriteStop {
  final String name;
  final List<BusInfo> buses;
  const FavoriteStop({required this.name, required this.buses});
}

class BusInfo {
  final String line;
  final String direction;
  final String firstIn;
  final int firstScore;
  final String secondIn;
  final int secondScore;
  const BusInfo({
    required this.line,
    required this.direction,
    required this.firstIn,
    required this.firstScore,
    required this.secondIn,
    required this.secondScore,
  });
}
