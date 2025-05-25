// lib/screens/search_result_screen.dart

import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;
  const SearchResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String _sortBy = '시간순';

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();
    final t = MaterialLocalizations.of(context).formatTimeOfDay(now);

    return Scaffold(
      // ─── 상단 AppBar ───────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '검색 결과',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),

      // ─── 본문 ─────────────────────────────────────────
      body: SafeArea(
        child: Column(
          children: [
            // 1) 검색어 표시 + 재검색
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: TextEditingController(text: widget.query),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: '장소를 입력하세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onSubmitted: (_) {
                  // 필요 시 재검색 로직
                },
              ),
            ),

            // 2) 오늘 XX 출발 + 정렬 드롭다운
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Text('오늘 $t 출발'),
                  const Spacer(),
                  DropdownButton<String>(
                    value: _sortBy,
                    items: ['시간순', '혼잡도순']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _sortBy = v);
                    },
                  ),
                ],
              ),
            ),

            // 3) 결과 리스트 (예시 카드)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: const [
                  // TODO: 실제 RouteOptionCard 위젯으로 교체하세요
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),

      // ─── 하단 내비게이션 바 (선택) ───────────────────────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Home 탭이 1이라면
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
