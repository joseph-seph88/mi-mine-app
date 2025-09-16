import 'package:mimine/common/entities/mission_entity.dart';

class MissionsMock {
  static List<MissionEntity> getMockMissions() {
    final now = DateTime.now();

    return [
      MissionEntity(
        missionId: 'exploration_001',
        title: '한강공원 탐험하기',
        description: '한강공원의 숨겨진 명소 3곳을 방문해보세요',
        type: MissionType.exploration,
        status: MissionStatus.inProgress,
        currentProgress: 2,
        targetProgress: 3,
        rewardPoints: 150,
        imageUrl: 'https://picsum.photos/300/200?random=1',
        startDate: now.subtract(const Duration(days: 2)),
        endDate: now.add(const Duration(days: 5)),
        tags: ['한강', '공원', '자연'],
        location: '서울특별시 한강공원',
      ),

      MissionEntity(
        missionId: 'exploration_002',
        title: '북촌 한옥마을 둘러보기',
        description: '전통 한옥의 아름다움을 느껴보세요',
        type: MissionType.exploration,
        status: MissionStatus.notStarted,
        currentProgress: 0,
        targetProgress: 1,
        rewardPoints: 100,
        imageUrl: 'https://picsum.photos/300/200?random=2',
        startDate: now,
        endDate: now.add(const Duration(days: 7)),
        tags: ['한옥', '전통', '문화'],
        location: '서울특별시 종로구 북촌',
      ),

      MissionEntity(
        missionId: 'exploration_003',
        title: '명동 맛집 탐방',
        description: '명동의 �숨겨진 맛집 5곳을 발견해보세요',
        type: MissionType.exploration,
        status: MissionStatus.completed,
        currentProgress: 5,
        targetProgress: 5,
        rewardPoints: 200,
        imageUrl: 'https://picsum.photos/300/200?random=3',
        startDate: now.subtract(const Duration(days: 10)),
        endDate: now.subtract(const Duration(days: 1)),
        completedAt: now.subtract(const Duration(days: 2)),
        tags: ['맛집', '음식', '명동'],
        location: '서울특별시 중구 명동',
      ),

      // 주간 미션들
      MissionEntity(
        missionId: 'weekly_001',
        title: '이번 주 게시글 3개 작성하기',
        description: '여행 경험을 다른 사람들과 공유해보세요',
        type: MissionType.weekly,
        status: MissionStatus.inProgress,
        currentProgress: 1,
        targetProgress: 3,
        rewardPoints: 120,
        imageUrl: 'https://picsum.photos/300/200?random=4',
        startDate: _getStartOfWeek(now),
        endDate: _getEndOfWeek(now),
        tags: ['게시글', '공유', '소통'],
      ),

      MissionEntity(
        missionId: 'weekly_002',
        title: '새로운 장소 5곳 체크인',
        description: '이번 주에 새로운 장소들을 탐험해보세요',
        type: MissionType.weekly,
        status: MissionStatus.inProgress,
        currentProgress: 3,
        targetProgress: 5,
        rewardPoints: 100,
        imageUrl: 'https://picsum.photos/300/200?random=5',
        startDate: _getStartOfWeek(now),
        endDate: _getEndOfWeek(now),
        tags: ['체크인', '탐험', '새로운장소'],
      ),

      // 월간 미션들
      MissionEntity(
        missionId: 'monthly_001',
        title: '이달의 여행 계획 세우기',
        description: '다음 달 여행 일정을 상세히 계획해보세요',
        type: MissionType.monthly,
        status: MissionStatus.notStarted,
        currentProgress: 0,
        targetProgress: 1,
        rewardPoints: 300,
        imageUrl: 'https://picsum.photos/300/200?random=6',
        startDate: _getStartOfMonth(now),
        endDate: _getEndOfMonth(now),
        tags: ['계획', '여행', '준비'],
      ),

      MissionEntity(
        missionId: 'monthly_002',
        title: '월간 사진 챌린지',
        description: '매일 다른 테마의 사진을 찍어 업로드하세요',
        type: MissionType.monthly,
        status: MissionStatus.inProgress,
        currentProgress: 12,
        targetProgress: 30,
        rewardPoints: 500,
        imageUrl: 'https://picsum.photos/300/200?random=7',
        startDate: _getStartOfMonth(now),
        endDate: _getEndOfMonth(now),
        tags: ['사진', '챌린지', '창작'],
      ),

      MissionEntity(
        missionId: 'monthly_003',
        title: '친구들과 함께하는 모험',
        description: '친구 10명과 함께 다양한 활동을 경험해보세요',
        type: MissionType.monthly,
        status: MissionStatus.completed,
        currentProgress: 10,
        targetProgress: 10,
        rewardPoints: 400,
        imageUrl: 'https://picsum.photos/300/200?random=8',
        startDate: now.subtract(const Duration(days: 25)),
        endDate: now.add(const Duration(days: 5)),
        completedAt: now.subtract(const Duration(days: 3)),
        tags: ['친구', '모험', '소통'],
      ),
    ];
  }

  static List<MissionEntity> getActiveMissions() {
    return getMockMissions().where((mission) => mission.isActive).toList();
  }

  static List<MissionEntity> getCompletedMissions() {
    return getMockMissions().where((mission) => mission.isCompleted).toList();
  }

  static List<MissionEntity> getMissionsByType(MissionType type) {
    return getMockMissions().where((mission) => mission.type == type).toList();
  }

  static DateTime _getStartOfWeek(DateTime date) {
    final daysFromMonday = date.weekday - 1;
    return DateTime(
      date.year,
      date.month,
      date.day,
    ).subtract(Duration(days: daysFromMonday));
  }

  static DateTime _getEndOfWeek(DateTime date) {
    final daysFromMonday = date.weekday - 1;
    return DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: daysFromMonday))
        .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
  }

  static DateTime _getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime _getEndOfMonth(DateTime date) {
    final nextMonth = date.month == 12
        ? DateTime(date.year + 1, 1, 1)
        : DateTime(date.year, date.month + 1, 1);
    return nextMonth.subtract(const Duration(microseconds: 1));
  }
}
