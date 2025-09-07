class MyInfoMock {
  /// JSON 형태의 내정보 더미 데이터
  static Map<String, dynamic> get myInfoJson => {
        'id': 'user_12345',
        'nickname': 'Joseph88',
        'email': 'joseph88@example.com',
        'motto': '내일은 존재하지 않는다. 오늘만이 존재할뿐이다.',
        'profileImage': null,
        'accessToken': 'mock_access_token_12345',
        'refreshToken': 'mock_refresh_token_67890',
        'bestContents': [
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=200&fit=crop',
            'title': '🌅 일출의 순간을 담은 아름다운 풍경화',
            'description':
                '새벽의 첫 빛이 바다를 비추는 순간의 신비로움을 캔버스에 담았습니다. 자연의 아름다움과 평화로움을 느낄 수 있는 작품입니다.',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400&h=200&fit=crop',
            'title': '🎨 추상적 감정을 표현한 현대 미술',
            'description':
                '내면의 감정과 생각을 색채와 형태로 자유롭게 표현한 추상 작품입니다. 관람자의 상상력을 자극하는 독특한 매력이 있습니다.',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400&h=200&fit=crop',
            'title': '🌸 봄의 정원을 그린 수채화',
            'description':
                '따뜻한 봄날의 정원에서 피어나는 꽃들의 생동감 넘치는 모습을 부드러운 수채화 기법으로 표현했습니다.',
          },
        ],
        'allContents': [
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
            'title': '✨ 오늘의 일상이 예술이 되는 순간',
            'description':
                '평범한 일상 속에서 발견한 아름다운 순간들을 사진으로 기록했습니다. 작은 것들의 소중함을 느껴보세요.',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
            'title': '🎭 감정의 색깔을 담은 인물화',
            'description':
                '모델의 내면 깊숙한 감정을 색채와 붓터치로 섬세하게 표현한 인물화 작품입니다. 인간의 복잡한 감정을 시각적으로 담아냈습니다.',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
            'title': '🏙️ 도시의 밤을 그린 야경화',
            'description':
                '화려한 네온사인과 건물들의 불빛이 어우러진 도시의 밤 풍경을 생생하게 그려낸 야경화입니다. 현대 도시의 역동적인 모습을 담았습니다.',
          },
          {
            'imageUrl':
                'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=200&fit=crop',
            'title': '🌿 자연과 인간의 조화를 그린 작품',
            'description':
                '자연 속에서 인간이 어떻게 조화롭게 살아갈 수 있는지를 주제로 한 작품입니다. 환경에 대한 메시지를 담고 있습니다.',
          },
        ],
        'friends': [
          {
            'id': 'user_22222',
            'nickname': '이영희',
            'email': 'leeyh@example.com',
          },
          {
            'id': 'user_33333',
            'nickname': '박민수',
            'email': 'parkms@example.com',
          },
          {
            'id': 'user_44444',
            'nickname': '이지은',
            'email': 'lejieun@example.com',
          },
        ],
        'followers': [
          {
            'id': 'user_55555',
            'nickname': '김영희',
            'email': 'kimyeongh@example.com',
          },
          {
            'id': 'user_66666',
            'nickname': '이영희',
            'email': 'leeyh@example.com',
          },
        ],
      };
}
