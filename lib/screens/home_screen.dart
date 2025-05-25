// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:busapp/widgets/app_search_bar.dart';
import 'package:busapp/widgets/favorite_card.dart';
import 'package:busapp/models/favorite_stop.dart';
import 'package:busapp/screens/search_result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final DraggableScrollableController _sheetCtrl = DraggableScrollableController();
  bool _isSheetOpen = false;

  // 고정된 시작 위치 (충남대 공대 5호관)
  final NLatLng _currentPos = const NLatLng(36.36997, 127.34789);

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
      ],
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  /// 검색 버튼 또는 엔터 입력 시 호출
  void _onSearch() {
    final q = _searchCtrl.text.trim();
    if (q.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SearchResultScreen(query: q)),
    );
  }

  /// 하단 시트 드래그 처리
  void _handleDrag(DragUpdateDetails details) {
    if (!_isSheetOpen && details.delta.dy < -5) {
      _sheetCtrl.animateTo(0.8,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      _isSheetOpen = true;
    } else if (_isSheetOpen && details.delta.dy > 5) {
      _sheetCtrl.animateTo(0.15,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      _isSheetOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          // 1) 네이버 지도 배경
          NaverMap(
            options: NaverMapViewOptions(
              mapType: NMapType.basic,
              initialCameraPosition: NCameraPosition(target: _currentPos, zoom: 14),
              locationButtonEnable: true,
            ),
            onMapReady: (ctrl) => ctrl.updateCamera(
              NCameraUpdate.withParams(target: _currentPos, zoom: 14),
            ),
          ),

          // 2) 검색창
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: AppSearchBar(
              controller: _searchCtrl,
              onSubmitted: (_) => _onSearch(),
              onTapSearch: _onSearch,
            ),
          ),

          // 3) 즐겨찾기 하단 시트
          DraggableScrollableSheet(
            controller: _sheetCtrl,
            initialChildSize: 0.15, // 헤더 높이
            minChildSize: 0.15,
            maxChildSize: 0.8,
            builder: (ctx, scrollCtrl) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F0E3),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                ),
                child: Column(
                  children: [
                    // 드래그 핸들 + 타이틀
                    GestureDetector(
                      onVerticalDragUpdate: _handleDrag,
                      behavior: HitTestBehavior.translucent,
                      child: Column(children: const [
                        SizedBox(height: 8),
                        SizedBox(
                          width: 40,
                          height: 4,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(children: [
                            Icon(Icons.star, color: Colors.orange),
                            SizedBox(width: 8),
                            Text('즐겨찾기',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ]),
                        ),
                      ]),
                    ),

                    // 즐겨찾기 카드 리스트
                    Expanded(
                      child: ListView.builder(
                        controller: scrollCtrl,
                        itemCount: _favorites.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: FavoriteCard(_favorites[i]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
