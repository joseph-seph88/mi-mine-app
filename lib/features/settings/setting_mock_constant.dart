import 'package:flutter/material.dart';
import 'package:mimine/features/settings/domain/entites/activity_item.dart';
import 'package:mimine/features/settings/domain/entites/contact_item_entity.dart';
import 'package:mimine/features/settings/domain/entites/snslink_entity.dart';

abstract class SettingMockConstant {
  static List<ContactItem> get contactItems => [
    ContactItem(
      name: '김민수',
      email: 'minsu@example.com',
      phone: '010-1234-5678',
      isVerified: true,
    ),
    ContactItem(
      name: '이지은',
      email: 'jieun@example.com',
      phone: '010-2345-6789',
      isVerified: false,
    ),
    ContactItem(
      name: '박준호',
      email: 'junho@example.com',
      phone: '010-3456-7890',
      isVerified: true,
    ),
  ];

  static List<SnsLink> get snsLinkMockList => [
    SnsLink(
      platform: 'Instagram',
      username: '@mimine_user',
      url: 'https://instagram.com/mimine_user',
      isConnected: true,
      icon: Icons.camera_alt_outlined,
      color: Colors.purple,
    ),
    SnsLink(
      platform: 'Twitter',
      username: '@mimine_user',
      url: 'https://twitter.com/mimine_user',
      isConnected: false,
      icon: Icons.alternate_email_outlined,
      color: Colors.blue,
    ),
    SnsLink(
      platform: 'Facebook',
      username: 'Mimine User',
      url: 'https://facebook.com/mimine_user',
      isConnected: true,
      icon: Icons.facebook_outlined,
      color: Colors.indigo,
    ),
    SnsLink(
      platform: 'YouTube',
      username: 'Mimine Channel',
      url: 'https://youtube.com/@mimine_user',
      isConnected: false,
      icon: Icons.play_circle_outline,
      color: Colors.red,
    ),
    SnsLink(
      platform: 'TikTok',
      username: '@mimine_user',
      url: 'https://tiktok.com/@mimine_user',
      isConnected: false,
      icon: Icons.music_note_outlined,
      color: Colors.black,
    ),
  ];

  static List<ActivityItem> get recentActivities => [
    ActivityItem(
      title: '새 게시글 업로드',
      description: '여행지 추가',
      time: '2시간 전',
      icon: Icons.add_photo_alternate_outlined,
      color: Colors.blue,
    ),
    ActivityItem(
      title: '금주 미션 업데이트',
      description: '맛집 리스트 추가',
      time: '1일 전',
      icon: Icons.task_alt_outlined,
      color: Colors.green,
    ),
    ActivityItem(
      title: '친구 요청 수락',
      description: '김민수님과 친구가 되었습니다',
      time: '2일 전',
      icon: Icons.person_add_outlined,
      color: Colors.orange,
    ),
    ActivityItem(
      title: '댓글 작성',
      description: '서울 맛집 추천 게시글에 댓글',
      time: '3일 전',
      icon: Icons.comment_outlined,
      color: Colors.purple,
    ),
    ActivityItem(
      title: '좋아요',
      description: '5개의 게시글에 좋아요',
      time: '4일 전',
      icon: Icons.favorite_outline,
      color: Colors.red,
    ),
  ];
}
