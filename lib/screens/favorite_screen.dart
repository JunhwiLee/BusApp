// lib/screens/favorite_screen.dart

import 'package:flutter/material.dart';
import 'package:busapp/widgets/app_search_bar.dart';
import 'package:busapp/widgets/favorite_card.dart';
import 'package:busapp/models/favorite_stop.dart';
import 'package:busapp/screens/search_result_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // 검색창 컨트롤러
  final TextEditingController _searchCtrl = TextEditingController();

  // 예시 즐겨찾기 데이터
  final List<FavoriteStop> _favorites = [
    FavoriteStop(
      name: '반석고등학교',
      buses: [
        BusInfo(
          line: '114',
          direction: '원내동공영차고지 방향',
          firstIn: '7분 후',
          firstScore: 60,
          secondIn: '회차 대기',
          secondScore: 40,
        ),
        BusInfo(
          line: '119',
          direction: '효동네거리 방향',
          firstIn: '10분 후',
          firstScore: 60,
          secondIn: '20분 후',
          secondScore: 40,
        ),
      ],
    ),
    FavoriteStop(
      name: '충남대학교',
      buses: [
        BusInfo(
          line: '1002',
          direction: '노은휴먼시아4단지 방향',
          firstIn: '12분 후',
          firstScore: 60,
          secondIn: '40분 후',
          secondScore: 40,
        ),
        BusInfo(
          line: '102',
          direction: '안산동 방향',
          firstIn: '3분 후',
          firstScore: 60,
          secondIn: '23분 후',
          secondScore: 40,
        ),
        // …추가 가능
      ],
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onSearch() {
    final q = _searchCtrl.text.trim();
    if (q.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SearchResultScreen(query: q)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1) 검색바
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: AppSearchBar(
                controller: _searchCtrl,
                onSubmitted: (_) => _onSearch(),
                onTapSearch: _onSearch,
              ),
            ),

            // 2) 즐겨찾기 타이틀
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    '즐겨찾기',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // 3) 즐겨찾기 카드 리스트
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: _favorites.length,
                itemBuilder: (context, i) {
                  return FavoriteCard(_favorites[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
