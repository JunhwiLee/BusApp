// lib/widgets/favorite_card.dart

import 'package:flutter/material.dart';
import 'package:busapp/models/favorite_stop.dart';
import 'package:busapp/screens/route_screen.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteStop data;
  const FavoriteCard(this.data, {Key? key}) : super(key: key);

  // 혼잡도 점수에 따른 이모지 아이콘
  IconData _iconForScore(int score) {
    if (score < 50) return Icons.sentiment_very_dissatisfied;
    if (score < 80) return Icons.sentiment_dissatisfied;
    return Icons.sentiment_satisfied;
  }

  @override
  Widget build(BuildContext context) {
    // 편의상 첫 번째 버스 번호를 routeNumber 로 전달
    final routeNumber = data.buses.first.line;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RouteScreen(routeNumber: routeNumber),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 장소명 헤더
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFD4D8C3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Text(
                data.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // 버스 정보 행들
            ...data.buses.map((b) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Text(b.line, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(b.direction, style: const TextStyle(fontSize: 12))),
                  const SizedBox(width: 8),
                  Text(b.firstIn, style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  Icon(_iconForScore(b.firstScore), size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text('${b.firstScore}점', style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 16),
                  Text(b.secondIn, style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  Icon(_iconForScore(b.secondScore), size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text('${b.secondScore}점', style: const TextStyle(fontSize: 12)),
                ],
              ),
            )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
