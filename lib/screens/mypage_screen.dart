// lib/screens/my_page_screen.dart

import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  // 더미 공지 목록
  final List<String> _notices = const [
    '[공지] 2025.05.09 정기 서비스 점검 안내',
    '[서비스 운영 공지] 장기간 미사용 유저 대상 안내',
    '[서비스 운영 공지] 장기간 미사용 유저 대상 안내',
    '[서비스 운영 공지] 장기간 미사용 유저 대상 안내',
    '[서비스 운영 공지] 장기간 미사용 유저 대상 안내',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ─── 프로필 카드 ─────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0E3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 상단: 아바타 + 이름
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade400,
                        child: const Icon(Icons.person, size: 32, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '이땡땡',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 아이디 항목
                  Row(
                    children: const [
                      Text('아이디', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 8),
                      Text('abc0518'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // 정보 변경
                  InkWell(
                    onTap: () {
                      // 정보 변경 액션
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: const [
                          Text('정보 변경', style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── 즐겨찾기 / 검색 기록 ──────────────────────────
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0E3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildMenuTile(
                    title: '즐겨찾기 관리',
                    onTap: () {
                      // 즐겨찾기 관리 이동
                    },
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  _buildMenuTile(
                    title: '검색 기록',
                    onTap: () {
                      // 검색 기록 이동
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── 공지사항 ─────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0E3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '공지사항',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // 공지 리스트 (스크롤 가능하게 높이 제한)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 150),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _notices
                            .map((n) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            n,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ─── 고객 문의 ─────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0E3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: _buildMenuTile(
                title: '고객 문의',
                onTap: () {
                  // 고객 문의 액션
                },
              ),
            ),

            const SizedBox(height: 32),

            // ─── 로그아웃 버튼 ─────────────────────────────────
            OutlinedButton(
              onPressed: () {
                // 로그아웃 액션
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Colors.grey.shade600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '로그아웃',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        child: Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
