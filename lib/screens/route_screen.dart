// lib/screens/route_screen.dart

import 'package:flutter/material.dart';

class RouteScreen extends StatelessWidget {
  /// 검색된 버스 번호를 텍스트 필드에 보여줍니다.
  final String routeNumber;
  const RouteScreen({Key? key, required this.routeNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 예시 정류장 목록
    const stops = [
      '유성온천역7번출구',
      '온천교',
      '충남대학교',
      '장대네거리',
      '죽동네거리',
    ];
    // 현재 버스가 위치해 있는 정류장 인덱스
    const currentIndex = 2;
    const lineColor = Color(0xFF808365);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E3),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                // ─── 검색바 ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(22),
                    child: TextField(
                      controller: TextEditingController(text: routeNumber),
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: '버스 번호 검색',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      readOnly: true,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ─── 타임라인 ────────────────────────────
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (_, __) => Column(
                      children: const [
                        SizedBox(height: 8),
                        Center(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lineColor,
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                            child: SizedBox(width: 4, height: 16),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                    itemCount: stops.length,
                    itemBuilder: (context, i) {
                      final isCurrent = i == currentIndex;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ① 타임라인 축
                            SizedBox(
                              width: 24,
                              child: Column(
                                children: [
                                  Container(
                                    width: 4,
                                    height: isCurrent ? 48 : 16,
                                    color: lineColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),

                            // ② 버스 아이콘 (현위치)
                            if (isCurrent)
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.directions_bus,
                                  size: 32,
                                  color: lineColor,
                                ),
                              ),

                            // ③ 정류장명
                            Expanded(
                              child: Text(
                                stops[i],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),

                            // ④ 점수 & 이모지 (현위치)
                            if (isCurrent)
                              Row(
                                children: const [
                                  Icon(Icons.sentiment_neutral, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text('55점', style: TextStyle(fontSize: 14)),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // ─── 뒤로가기 버튼 ─────────────────────────────
            Positioned(
              top: 8,
              left: 8,
              child: Material(
                color: Colors.white.withOpacity(0.8),
                shape: const CircleBorder(),
                elevation: 2,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back, size: 24, color: Colors.black87),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
