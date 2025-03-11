# 🧩 KIDING

![Frame 25](https://github.com/user-attachments/assets/cac6f0a1-0683-4449-a3c4-0fab9e317fee)

## 📌 프로젝트 소개

### 🔍 프로젝트 개요
KIDING은 **실물 보드게임과 연동하여 부모님과 아이가 함께 소통하며 놀이를 즐길 수 있도록 돕는 보조 어플리케이션**입니다.  
사용자는 **실물 보드게임과 모바일 앱을 동시에 활용하여** 더욱 흥미로운 플레이 경험을 제공받을 수 있습니다. 
또한, 게임을 지속적으로 즐길 수 있도록 **게임 플레이 횟수에 따른 랭킹 시스템**을 도입하여 아이들의 흥미를 유도합니다.

---

## 🎮 주요 기능

### 🎲 보드게임 플레이 지원
- **키키의 하루**: 부모와 아이가 소통할 수 있도록 돕는 질문 카드덱을 활용한 보드게임  
- **키키의 우주여행**: 우주에 대한 호기심을 자극하는 질문 카드덱을 활용한 보드게임  
- **게임 진행 보조 기능 제공**:
  - 주사위 기능 제공  
  - 주사위에 따른 카드덱 안내  
  - 여러 명이 함께 플레이 가능  

### 🏆 랭킹 시스템
- 게임을 통해 획득한 ‘키딩칩’을 기준으로 **상위 6명의 플레이어 순위 제공**
- 랭킹 시스템을 통해 지속적인 플레이 동기 부여

### 🔍 검색 기능
- 보드게임 및 사용자 검색 기능 제공

### 👥 친구 관리
- 친구 추가 및 삭제 기능 지원

### 📖 마이페이지
- 즐겨찾기한 게임 목록 확인
- 보유한 키딩칩 개수 및 1위 경험 횟수 조회
- 동점자 수 등 다양한 플레이 기록 확인

---

## 🚀 기술 스택
| 구분 | 기술 |
|------|------|
| **Frontend** | Flutter |
| **State Management** | Provider |
| **Networking & API** | http, stomp_dart_client |
| **Database** | mysql_client, mysql1 |
| **Storage & Security** | flutter_secure_storage |
| **UI & Styling** | Flutter ScreenUtil, Cupertino Icons |
| **QR Code** | qr_code_scanner (로컬 플러그인) |
| **Media** | video_player, gif, image_picker |
| **Permissions** | permission_handler |
| **App Icons** | Flutter Launcher Icons |
| **Testing & Linting** | Flutter Test, Flutter Lints |
| **Fonts** | Nanum, NanumRegular |

---

## 📂 폴더 구조
```bash
├── README.md                  # 프로젝트 설명 문서
├── pubspec.yaml               # Flutter 프로젝트 설정 및 의존성 관리
├── 📂 lib/                     # Flutter 주요 코드
│   ├── main.dart               # 앱 실행 시작점
│   ├── 📂 core/                 # 공통적으로 사용되는 기능
│   │   ├── 📂 constants/        # 앱에서 사용되는 상수 정의
│   │   ├── 📂 routes/           # 라우팅 관리
│   │   ├── 📂 services/         # API 및 데이터 관리
│   │   ├── 📂 utils/            # 유틸리티 함수 (날짜, 문자열 처리 등)
│   │   └── 📂 widgets/          # 재사용 가능한 UI 위젯
│   ├── 📂 model/                # 데이터 모델
│   ├── 📂 screen/               # 화면 관련 코드
├── 📂 assets/                  # 정적 리소스 (이미지, 아이콘, 폰트, 데이터 파일)
```

---

## 🔗 API 연동

### 📍 기본 API 주소
- API_URL=http://3.37.76.76:8081

### ✅ API 연동 특징
- **HTTP 통신** (`http` 및 `stomp_dart_client` 패키지 활용)
- **JWT 기반 사용자 인증** (`flutter_secure_storage`를 활용한 토큰 관리)
- **주요 기능 API 연동**:
  - 🎲 **보드게임 관련 API**: 게임 플레이 데이터 전송 및 저장
  - 🏆 **랭킹 API**: 키딩칩을 기준으로 랭킹 조회
  - 🔍 **검색 API**: 보드게임 및 사용자 검색 기능 제공
  - 👥 **친구 관리 API**: 친구 추가 및 삭제
  - 📖 **마이페이지 API**: 즐겨찾기한 게임, 키딩칩 개수, 1위 경험 수 등 조회

---

## 🛠️ 주요 기능

### 🎲 보드게임 플레이 지원  
| 항목 | 내용 |
|------|------|
| **기능** | 실물 보드게임과 연동하여 **주사위 굴리기, 카드덱 안내, 멀티플레이 지원** 등의 기능을 제공합니다. |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/bfb0c467-50ec-41f7-9276-2ce1fcfda02c" width="200px"> |

### 🏆 랭킹 시스템  
| 항목 | 내용 |
|------|------|
| **기능** | **키딩칩(게임 포인트)**을 기준으로 **상위 6명의 랭킹을 제공**하여 지속적인 플레이 동기 부여 |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/6c9fe45d-22e0-4351-a6b0-2a71d1818dce" width="200px"> |

### 🔍 검색 기능  
| 항목 | 내용 |
|------|------|
| **기능** | 보드게임 및 사용자 검색 기능 제공 |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/c48caa08-aa75-47a0-a093-3ab300dac447" width="200px"> |

### 👥 친구 관리  
| 항목 | 내용 |
|------|------|
| **기능** | 친구 추가 및 삭제 기능 지원 |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/6583ddd0-c3c5-497a-ac5b-238b20c69666" width="200px"> |

### 📖 마이페이지  
| 항목 | 내용 |
|------|------|
| **기능** | 즐겨찾기한 게임 목록 확인, **보유 키딩칩 개수, 1위 경험 횟수, 동점자 수** 등 플레이 기록 확인 |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/f0ad1202-a629-442c-ba79-a36db68005f0" width="200px"> |

---

## 📢 팀원 소개

| 이름 | 역할 | GitHub |
|------|------|--------|
| 전시원 | 프론트엔드 개발 | [@siiion](https://github.com/siiion) |
