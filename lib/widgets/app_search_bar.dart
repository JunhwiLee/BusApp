// lib/widgets/app_search_bar.dart

import 'package:flutter/material.dart';

/// 검색창 위젯: controller, 힌트 텍스트, 엔터(submit)·돋보기(onTap) 콜백을 받습니다.
class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTapSearch;

  const AppSearchBar({
    Key? key,
    required this.controller,
    this.hintText = '장소, 버스 검색',
    this.onSubmitted,
    this.onTapSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(22),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onSubmitted: onSubmitted,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: onTapSearch,
          ),
        ],
      ),
    );
  }
}
