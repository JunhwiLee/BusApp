// lib/widgets/favorite_card.dart

import 'package:flutter/material.dart';
import 'package:busapp/models/favorite_stop.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteStop stop;
  const FavoriteCard(this.stop, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEFF1E6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 정류장 이름
            Text(
              stop.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // 각 버스 정보
            ...stop.buses.map((bus) => _BusRow(bus)).toList(),
          ],
        ),
      ),
    );
  }
}

/// 버스 1줄(row) 위젯
class _BusRow extends StatelessWidget {
  final BusInfo info;
  const _BusRow(this.info, {Key? key}) : super(key: key);

  // score 에 따라 색상과 이모지 결정
  Color _scoreColor(int score) {
    if (score <= 25) return Colors.red;
    if (score <= 50) return Colors.orange;
    if (score <= 75) return Colors.green;
    return Colors.blue;
  }

  String _scoreEmoji(int score) {
    if (score <= 25) return '😢';
    if (score <= 50) return '😐';
    if (score <= 75) return '🙂';
    return '😃';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 첫 번째 도착 정보 (line + direction)
          Text(
            '${info.line} ${info.direction}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
          ),
          const SizedBox(height: 4),

          // 도착 시간과 점수
          Row(
            children: [
              // 첫 번째 도착
              Text(info.firstIn, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Text(
                _scoreEmoji(info.firstScore),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 4),
              Text(
                '${info.firstScore}점',
                style: TextStyle(
                  fontSize: 14,
                  color: _scoreColor(info.firstScore),
                  fontWeight: FontWeight.bold,
                ),
              ),

              // 두 번째 도착 (optional)
              const SizedBox(width: 16),
              Text(info.secondIn, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Text(
                _scoreEmoji(info.secondScore),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 4),
              Text(
                '${info.secondScore}점',
                style: TextStyle(
                  fontSize: 14,
                  color: _scoreColor(info.secondScore),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
