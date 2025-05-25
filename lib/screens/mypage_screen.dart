import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 프로필 카드
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
                  const Text(
                    '이땡땡',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text('아이디', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 16),
                      Text('abc0518'),
                      Spacer(),
                      TextButton(onPressed: null, child: Text('변경하기')),
                    ],
                  ),
                  Row(
                    children: const [
                      Text('비밀번호', style: TextStyle(color: Colors.grey)),
                      Spacer(),
                      TextButton(onPressed: null, child: Text('변경하기')),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 메뉴
            _MenuItem(title: '공지사항'),
            _MenuItem(title: '즐겨찾기 관리', actionLabel: '관리'),
            _MenuItem(title: '고객센터', actionLabel: '문의'),

            const SizedBox(height: 32),

            // 로그아웃
            OutlinedButton(onPressed: () {}, child: const Text('로그아웃')),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String? actionLabel;
  const _MenuItem({Key? key, required this.title, this.actionLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: actionLabel != null
          ? TextButton(onPressed: () {}, child: Text(actionLabel!))
          : null,
      onTap: () {},
    );
  }
}
