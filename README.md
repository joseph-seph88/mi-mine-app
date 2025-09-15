# MI-MINE

<div align="center">
  <img src="https://github.com/user-attachments/assets/322129c4-65ff-4fb6-9989-67ca45462cf1" alt="MI-MINE App Icon" width="120" height="120">
  <p>Mining Myself Commnunity App</p>
</div>

## 📱 App Info
- **App Name**: MI-MINE
- **Developer**: Joseph88
- **Flutter Version**: 3.32.7
- **Dart Version**: 3.8.1

## 🏗️ 아키텍처

### Clean Architecture + 기능 기반 구조

```
lib/
├── app/                    # 애플리케이션 레이어
│   ├── app.dart           # 메인 앱 위젯
│   ├── bootstrap.dart     # 앱 초기화
│   └── router/            # 네비게이션 및 라우팅
├── core/                  # 코어 레이어 (기능 간 공유)
│   ├── configs/           # 앱 설정
│   ├── core_di/           # 의존성 주입 설정
│   ├── services/          # 코어 서비스
│   └── utils/             # 유틸리티 함수
├── features/              # 기능 모듈
│   ├── auth/              # 인증 기능
│   ├── map/               # 지도 기능
│   ├── shell/             # 메인 셸/레이아웃
│   ├── splash/            # 스플래시 화면
│   └── user/              # 사용자 관리
└── common/                # 공유 컴포넌트
    ├── constants/         # 앱 상수
    ├── enums/             # 공유 열거형
    ├── styles/            # 앱 스타일링
    └── widgets/           # 재사용 가능한 위젯
```

## 📁 기능 구조
```
feature_name/
├── presentation/
│   ├── cubits/         # Cubit 상태 관리
│   ├── pages/          # 화면 위젯
│   └── widgets/        # 기능별 위젯
├── domain/             # 비즈니스 로직 (향후)
├── data/               # 데이터 레이어 (향후)
└── feature_di/         # 기능 의존성 주입
```

## 📱 앱 스크린샷

<div align="center">
  <img src="https://github.com/user-attachments/assets/6f278190-9f14-4b6b-9cae-01d46e95675e" alt="Home Screen" width="200">
  <img src="https://github.com/user-attachments/assets/29fb0246-8f1d-4012-8291-7e9d2705bb95" alt="Map Feature" width="200">
  <img src="https://github.com/user-attachments/assets/9923e189-9836-42f4-b3f4-4b1260d73d10" alt="Community Feature" width="200">
</div>


<div align="center">
  <img src="https://github.com/user-attachments/assets/b2803291-f0b7-4d47-a9d4-380b561cb819" alt="Splash Screen" width="200">
  <img src="https://github.com/user-attachments/assets/6f278190-9f14-4b6b-9cae-01d46e95675e" alt="Community Screen" width="200">
  <img src="https://github.com/user-attachments/assets/cf794f3d-822b-4ef9-8479-b43049c39057" alt="Settings Screen" width="200">
</div>

