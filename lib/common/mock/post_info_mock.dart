abstract class PostInfoMock {
  static List<Map<String, dynamic>> get myPostInfoJson => [
    {
      'postId': '1',
      'userId': '88',
      'nickname': 'Joseph88',
      'profileImage': null,
      'likeCount': 2,
      'commentCount': 2,
      'shareCount': 2,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
      'title': '✨ 오늘의 일상이 예술이 되는 순간',
      'description': '평범한 일상 속에서 발견한 아름다운 순간들을 사진으로 기록했습니다. 작은 것들의 소중함을 느껴보세요.',
    },
    {
      'postId': '2',
      'userId': '88',
      'nickname': 'Joseph88',
      'profileImage': null,
      'likeCount': 3,
      'commentCount': 3,
      'shareCount': 3,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
      'title': '🎭 감정의 색깔을 담은 인물화',
      'description':
          '모델의 내면 깊숙한 감정을 색채와 붓터치로 섬세하게 표현한 인물화 작품입니다. 인간의 복잡한 감정을 시각적으로 담아냈습니다.',
    },
    {
      'postId': '3',
      'userId': '88',
      'nickname': 'Joseph88',
      'profileImage': null,
      'likeCount': 3,
      'commentCount': 3,
      'shareCount': 3,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
      'title': '🏙️ 도시의 밤을 그린 야경화',
      'description':
          '화려한 네온사인과 건물들의 불빛이 어우러진 도시의 밤 풍경을 생생하게 그려낸 야경화입니다. 현대 도시의 역동적인 모습을 담았습니다.',
    },
    {
      'postId': '4',
      'userId': '88',
      'nickname': 'Joseph88',
      'profileImage': null,
      'likeCount': 4,
      'commentCount': 4,
      'shareCount': 4,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
      'title': '🌿 자연과 인간의 조화를 그린 작품',
      'description':
          '자연 속에서 인간이 어떻게 조화롭게 살아갈 수 있는지를 주제로 한 작품입니다. 환경에 대한 메시지를 담고 있습니다.',
    },
    {
      'postId': '5',
      'userId': '88',
      'nickname': 'Joseph88',
      'profileImage': null,
      'likeCount': 20,
      'commentCount': 10,
      'shareCount': 30,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop',
      'title': '🌅 일출의 순간을 담은 아름다운 풍경화',
      'description':
          '새벽의 첫 빛이 바다를 비추는 순간의 신비로움을 캔버스에 담았습니다. 자연의 아름다움과 평화로움을 느낄 수 있는 작품입니다.',
    },
    {
      'postId': '6',
      'userId': '88',
      'nickname': 'Joseph88',
      'profileImage': null,
      'likeCount': 30,
      'commentCount': 10,
      'shareCount': 10,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400&h=200&fit=crop',
      'title': '🎨 추상적 감정을 표현한 현대 미술',
      'description':
          '내면의 감정과 생각을 색채와 형태로 자유롭게 표현한 추상 작품입니다. 관람자의 상상력을 자극하는 독특한 매력이 있습니다.',
    },
    {
      'postId': '7',
      'userId': '88',
      'nickname': 'Joseph88',
      'profileImage': null,
      'likeCount': 40,
      'commentCount': 10,
      'shareCount': 10,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400&h=200&fit=crop',
      'title': '🌸 봄의 정원을 그린 수채화',
      'description': '따뜻한 봄날의 정원에서 피어나는 꽃들의 생동감 넘치는 모습을 부드러운 수채화 기법으로 표현했습니다.',
    },
  ];

  static List<Map<String, dynamic>> get allPostInfoJson => [
    {
      'postId': '101',
      'userId': '23',
      'nickname': 'ArtLover_Seoul',
      'profileImage':
          'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100&h=100&fit=crop&crop=face',
      'likeCount': 156,
      'commentCount': 23,
      'shareCount': 45,
      'createdAt': DateTime.now()
          .subtract(Duration(hours: 2))
          .toIso8601String(),
      'updatedAt': DateTime.now()
          .subtract(Duration(hours: 2))
          .toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400&h=200&fit=crop',
      'title': '🎨 디지털 아트의 새로운 지평',
      'description':
          'AI와 전통 미술의 만남으로 탄생한 혁신적인 디지털 아트 작품입니다. 기술과 예술의 조화를 보여줍니다.',
    },
    {
      'postId': '102',
      'userId': '45',
      'nickname': 'NaturePhotographer',
      'profileImage':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
      'likeCount': 89,
      'commentCount': 12,
      'shareCount': 34,
      'createdAt': DateTime.now()
          .subtract(Duration(hours: 5))
          .toIso8601String(),
      'updatedAt': DateTime.now()
          .subtract(Duration(hours: 5))
          .toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop',
      'title': '🌊 바다의 신비로운 색채',
      'description': '깊은 바다 속에서 발견한 놀라운 색채의 해양 생물들을 촬영했습니다. 자연의 신비로움에 감탄합니다.',
    },
    {
      'postId': '103',
      'userId': '67',
      'nickname': 'StreetArtist_Min',
      'profileImage':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face',
      'likeCount': 234,
      'commentCount': 45,
      'shareCount': 67,
      'createdAt': DateTime.now()
          .subtract(Duration(hours: 8))
          .toIso8601String(),
      'updatedAt': DateTime.now()
          .subtract(Duration(hours: 8))
          .toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
      'title': '🏙️ 도시의 숨겨진 이야기',
      'description': '서울의 골목길에서 발견한 감동적인 벽화들입니다. 도시의 역사와 사람들의 이야기가 담겨있어요.',
    },
    {
      'postId': '104',
      'userId': '89',
      'nickname': 'CeramicMaster',
      'profileImage':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop&crop=face',
      'likeCount': 78,
      'commentCount': 15,
      'shareCount': 23,
      'createdAt': DateTime.now()
          .subtract(Duration(hours: 12))
          .toIso8601String(),
      'updatedAt': DateTime.now()
          .subtract(Duration(hours: 12))
          .toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400&h=200&fit=crop',
      'title': '🏺 전통 도예의 현대적 해석',
      'description': '한국의 전통 도예 기법을 현대적 감각으로 재해석한 작품들입니다. 과거와 현재의 만남이 인상적입니다.',
    },
    {
      'postId': '105',
      'userId': '12',
      'nickname': 'FashionDesigner_K',
      'profileImage':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop&crop=face',
      'likeCount': 345,
      'commentCount': 67,
      'shareCount': 89,
      'createdAt': DateTime.now()
          .subtract(Duration(hours: 18))
          .toIso8601String(),
      'updatedAt': DateTime.now()
          .subtract(Duration(hours: 18))
          .toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
      'title': '👗 지속가능한 패션의 미래',
      'description':
          '친환경 소재로 만든 패션 컬렉션입니다. 아름다움과 환경을 동시에 생각하는 패션의 새로운 방향을 제시합니다.',
    },
    {
      'postId': '106',
      'userId': '34',
      'nickname': 'FoodArtist_Jin',
      'profileImage':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&h=100&fit=crop&crop=face',
      'likeCount': 123,
      'commentCount': 28,
      'shareCount': 45,
      'createdAt': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
      'updatedAt': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400&h=200&fit=crop',
      'title': '🍰 케이크도 예술이 될 수 있다',
      'description': '일상의 디저트를 예술 작품으로 승화시킨 케이크 아트입니다. 맛과 아름다움의 완벽한 조화를 보여줍니다.',
    },
    {
      'postId': '107',
      'userId': '56',
      'nickname': 'MusicVisualizer',
      'profileImage':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
      'likeCount': 267,
      'commentCount': 34,
      'shareCount': 78,
      'createdAt': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
      'updatedAt': DateTime.now().subtract(Duration(days: 2)).toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop',
      'title': '🎵 음악을 시각화하다',
      'description': '음악의 감정과 리듬을 색채와 형태로 표현한 시각적 작품입니다. 듣는 예술을 보는 예술로 변환했습니다.',
    },
    {
      'postId': '108',
      'userId': '78',
      'nickname': 'Architect_Young',
      'profileImage':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face',
      'likeCount': 189,
      'commentCount': 41,
      'shareCount': 56,
      'createdAt': DateTime.now().subtract(Duration(days: 3)).toIso8601String(),
      'updatedAt': DateTime.now().subtract(Duration(days: 3)).toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400&h=200&fit=crop',
      'title': '🏗️ 미래 도시의 비전',
      'description': '지속가능하고 인간 중심적인 미래 도시 설계안입니다. 기술과 자연이 조화를 이룬 도시를 꿈꿉니다.',
    },
    {
      'postId': '109',
      'userId': '91',
      'nickname': 'DanceChoreographer',
      'profileImage':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop&crop=face',
      'likeCount': 145,
      'commentCount': 19,
      'shareCount': 32,
      'createdAt': DateTime.now().subtract(Duration(days: 4)).toIso8601String(),
      'updatedAt': DateTime.now().subtract(Duration(days: 4)).toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
      'title': '💃 움직임의 시각화',
      'description': '춤의 아름다운 움직임을 정적인 이미지로 포착한 작품입니다. 순간의 아름다움이 영원으로 남습니다.',
    },
    {
      'postId': '110',
      'userId': '13',
      'nickname': 'TechArtist_Kim',
      'profileImage':
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop&crop=face',
      'likeCount': 298,
      'commentCount': 52,
      'shareCount': 91,
      'createdAt': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
      'updatedAt': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
      'imageUrl':
          'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400&h=200&fit=crop',
      'title': '🤖 AI와 함께하는 창작',
      'description':
          '인공지능과 협업하여 만든 혁신적인 미디어 아트 작품입니다. 인간과 AI의 창작적 협력의 가능성을 보여줍니다.',
    },
  ];
}
