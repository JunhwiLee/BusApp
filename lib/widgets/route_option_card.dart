// lib/widgets/route_option_card.dart

import 'package:flutter/material.dart';
import 'package:busapp/screens/route_screen.dart';

/// 검색 결과에 나올 한 개의 경로 옵션 카드
class RouteOptionCard extends StatelessWidget {
  final String duration;         // ex: "29분"
  final String timeRange;        // ex: "오후 5:59 ~ 오후 6:28"
  final String price;            // ex: "1,500원"
  final double predictedComfort; // 예측된 쾌적도 점수
  final List<RouteSegment> segments;
  final String routeNumber;      // 눌렀을 때 전달할 노선 번호

  const RouteOptionCard({
    Key? key,
    required this.duration,
    required this.timeRange,
    required this.price,
    required this.predictedComfort,
    required this.segments,
    required this.routeNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F0E3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── 예측 쾌적도 ─────────────────────────
          Text(
            '예측 쾌적도: ${predictedComfort.toStringAsFixed(1)}점',
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          const SizedBox(height: 8),

          // ─── 소요 시간 & 요금 ───────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(duration,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(timeRange, style: const TextStyle(fontSize: 12)),
                  Text(price, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ─── 진행 바 ────────────────────────────────
          Stack(
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: (predictedComfort / 100).clamp(0.0, 1.0),
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ─── 구간별 설명 ─────────────────────────────
          ...segments.map((seg) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(seg.icon, size: 20, color: Colors.grey.shade700),
                const SizedBox(width: 6),
                Expanded(child: Text(seg.description, style: const TextStyle(fontSize: 14))),
                if (seg.score != null) ...[
                  const SizedBox(width: 6),
                  Icon(
                    // 점수별 표정
                    seg.score! <= 25
                        ? Icons.sentiment_very_dissatisfied
                        : seg.score! <= 50
                        ? Icons.sentiment_dissatisfied
                        : seg.score! <= 75
                        ? Icons.sentiment_satisfied
                        : Icons.sentiment_very_satisfied,
                    size: 16,
                    // 점수별 색상
                    color: seg.score! <= 25
                        ? Colors.red
                        : seg.score! <= 50
                        ? Colors.orange
                        : seg.score! <= 75
                        ? Colors.green
                        : Colors.blue,
                  ),
                  const SizedBox(width: 4),
                  Text('${seg.score}점', style: const TextStyle(fontSize: 12)),
                ],
              ],
            ),
          )),

          // ─── 상세 보기 버튼 ───────────────────────────
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(color: Colors.grey.shade600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              ),
              icon: const Icon(Icons.directions_bus, size: 16),
              label: const Text('노선 정보 더보기', style: TextStyle(fontSize: 12)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RouteScreen(routeNumber: routeNumber),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 카드 내부에서 표시할 한 구간 (버스, 환승, 도보 등)
class RouteSegment {
  final IconData icon;
  final String description;
  final int? score;

  const RouteSegment({
    required this.icon,
    required this.description,
    this.score,
  });
}
