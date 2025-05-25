// lib/screens/search_result_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:busapp/screens/route_screen.dart';
import 'package:busapp/widgets/route_option_card.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;
  const SearchResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String _sortBy = '시간순';
  final _rng = Random();
  late final List<_OptionData> _options;

  @override
  void initState() {
    super.initState();
    _options = _generateOptions(5); // 한 번만 생성
  }

  double _normal(double mu, double sigma) {
    final u1 = _rng.nextDouble();
    final u2 = _rng.nextDouble();
    final z0 = sqrt(-2 * log(u1)) * cos(2 * pi * u2);
    return mu + sigma * z0;
  }

  int _uniformInt(int a, int b) => a + _rng.nextInt(b - a + 1);
  String _randomFrom(List<String> arr) => arr[_rng.nextInt(arr.length)];

  List<_OptionData> _generateOptions(int n) {
    const busLines = ['114','119','1002','102','704'];

    return List<_OptionData>.generate(n, (_) {
      final travelTime   = (_normal(80,27.18).clamp(10.0,180.0)) as double;
      final transfers    = _uniformInt(0,3);
      final walkDist     = (_normal(550,174.67).clamp(50.0,1500.0)) as double;
      final depHour      = (_normal(13.33,5.41).clamp(0.0,23.99)) as double;
      final rawCongest   = (_normal(60, 15).clamp(0.0,100.0)) as double;
      final comfortScore = (_normal(60,15).clamp(0.0,100.0)) as double;
      final line         = _randomFrom(busLines);
      final weightedCongest = rawCongest.round();

      final segments = [
        RouteSegment(
          icon: Icons.directions_bus,
          description: '$line 번 승차',
          score: weightedCongest,
        ),
        RouteSegment(
          icon: Icons.directions_walk,
          description: '도보 ${walkDist.toStringAsFixed(0)}m',
          score: null,
        ),
      ];

      return _OptionData(
        duration: '${travelTime.toStringAsFixed(0)}분',
        timeRange: '오후 ${depHour.toStringAsFixed(2)} 출발',
        price: '${1500 + transfers*200}원',
        comfortScore: comfortScore,
        busLine: line,
        segments: segments,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // 정렬용 복사
    final list = List<_OptionData>.from(_options);
    if (_sortBy == '시간순') {
      list.sort((a, b) {
        final ai = double.parse(a.duration.replaceAll('분',''));
        final bi = double.parse(b.duration.replaceAll('분',''));
        return ai.compareTo(bi);
      });
    } else {
      list.sort((a, b) => b.comfortScore.compareTo(a.comfortScore));
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black87),
        title: const Text('검색 결과', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 검색어 + 정렬
            Padding(
              padding: const EdgeInsets.fromLTRB(16,8,16,4),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal:12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width:8),
                          Expanded(child: Text(widget.query)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width:12),
                  DropdownButton<String>(
                    value: _sortBy,
                    items: ['시간순','쾌적도순']
                        .map((s)=> DropdownMenuItem(value:s, child: Text(s)))
                        .toList(),
                    onChanged: (v)=> setState(()=> _sortBy = v!),
                  ),
                ],
              ),
            ),

            // 결과 리스트
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal:16, vertical:8),
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final o = list[i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RouteOptionCard(
                        duration: o.duration,
                        timeRange: o.timeRange,
                        price: o.price,
                        predictedComfort: o.comfortScore,
                        segments: o.segments,
                        routeNumber: o.busLine,
                      ),
                      const SizedBox(height:12),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionData {
  final String duration, timeRange, price, busLine;
  final double comfortScore;
  final List<RouteSegment> segments;
  _OptionData({
    required this.duration,
    required this.timeRange,
    required this.price,
    required this.comfortScore,
    required this.busLine,
    required this.segments,
  });
}
