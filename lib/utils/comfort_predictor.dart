// lib/utils/comfort_predictor.dart

class ComfortPredictor {
  // ---- 1) Training stats (from Python) ----
  static const List<String> contCols = [
    'travel_time_min',
    'walk_distance_m',
    'congestion',
    'transfers',
    'departure_hour',
  ];

  static const Map<String, double> contMean = {
    'travel_time_min': 79.773139,
    'walk_distance_m': 556.047455,
    'congestion': 0.632283,
    'transfers': 1.518400,
    'departure_hour': 13.330200,
  };

  static const Map<String, double> contStd = {
    'travel_time_min': 27.204616,
    'walk_distance_m': 174.447877,
    'congestion': 0.259404,
    'transfers': 1.121957,
    'departure_hour': 5.408853,
  };

  // 카테고리 리스트 (drop_first=False)
  static const List<String> busLineCats = [
    'Line 2', 'Line 3', 'Line 4', 'Line 5'
  ];
  static const List<String> weekdayCats = [
    'Mon','Sat','Sun','Thr','Tue','Wed'
  ];

  // ---- 2) Model parameters ----
  // theta shape (n_features+1, ) including bias first
  static const List<double> theta = [
    43.3804786,   // bias
    -7.68387352,  // travel_time_min
    -3.49932477,  // walk_distance_m
    -7.80333293,  // congestion
    -3.72608157,  // transfers
    -0.0242022095,// departure_hour
    2.15171837,
    2.15171837,   // bus_line_Line2
    2.16118279,   // bus_line_Line3
    2.14715665,   // bus_line_Line4
    2.14412234,   // bus_line_Line5
    2.98284487,   // weekday_Mon
    2.93816667,   // weekday_Sat
    2.98105867,   // weekday_Sun
    2.97050512,   // weekday_Thr
    2.98182559,   // weekday_Tue
    2.95319650,   // weekday_Wed
    2.95319650
  ];

  /// sample: 각 키를 담은 Map
  /// {
  ///   'travel_time_min': 60.0,
  ///   'walk_distance_m': 400.0,
  ///   'congestion': 0.3,
  ///   'transfers': 1.0,
  ///   'departure_hour': 8.0,
  ///   'bus_line': 'Line 2',
  ///   'weekday': 'Fri'
  /// }
  static double predict(Map<String, dynamic> sample) {
    // 1) 연속형 standardize
    final List<double> contFeatures = contCols.map((c) {
      final v = (sample[c] as num).toDouble();
      final mean = contMean[c]!;
      final std  = contStd[c]!;
      return (v - mean) / std;
    }).toList();

    // 2) 범주형 one-hot
    final String line = sample['bus_line'] as String;
    final String day  = sample['weekday']  as String;
    // drop_first = False: 모든 카테고리 dummy
    // but Python code used only cats in feature_names (bias excluded)
    final List<double> lineD = busLineCats.map((cat) => line == cat ? 1.0 : 0.0).toList();
    final List<double> dayD  = weekdayCats .map((cat) => day  == cat ? 1.0 : 0.0).toList();

    // 3) build full feature vector with bias
    final List<double> x = [1.0]  // bias
        + contFeatures         // 5
        + lineD                // 4
        + dayD;                // 6

    // 4) dot(theta, x)
    double y = 0.0;
    for (var i = 0; i < theta.length; i++) {
      y += theta[i] * x[i];
    }
    // Python predict: no clamp on lower bound, but example clamps 0..100
    return y.clamp(0.0, 100.0);
  }
}
