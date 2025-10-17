# 포미서비스 AI SNS 마케팅 랜딩 페이지

## 📌 프로젝트 소개

포미서비스 AI SNS 마케팅 서비스를 홍보하고 상담 신청을 받기 위한 단일 페이지 웹사이트입니다.

## 🎯 주요 기능

- **Hero Section**: 메인 비주얼과 CTA 버튼
- **Service Introduction**: 3가지 핵심 장점 소개
- **Features Section**: AI 기반 4가지 핵심 기능
- **Pricing Section**: 기존 업체와의 비교 테이블
- **Process Section**: 4단계 서비스 이용 프로세스
- **Testimonials Section**: 고객 후기
- **Contact Form**: 상담 신청 폼 (유효성 검증 포함)
- **Footer**: 회사 정보 및 링크

## 🛠️ 기술 스택

- **HTML5**: 시맨틱 마크업
- **CSS3**: 커스텀 CSS 변수 및 애니메이션
- **Vanilla JavaScript**: 인터랙션 및 폼 검증
- **Tailwind CSS**: 유틸리티 CSS 프레임워크

## 🎨 디자인 시스템

### 색상 팔레트 (UMAUMA Icons 테마)

```css
--primary-dark: #1243A6;    /* 진한 파랑 */
--primary: #1D64F2;         /* 밝은 파랑 */
--dark: #011C40;            /* 네이비 */
--light: #F2EED8;           /* 크림 */
--accent: #F24822;          /* 오렌지레드 */
```

### 폰트

- 제목: Noto Sans KR Bold
- 본문: Noto Sans KR Regular

### 반응형 브레이크포인트

- Mobile: 0 ~ 640px
- Tablet: 641px ~ 1024px
- Desktop: 1025px 이상

## 🚀 시작하기

### 1. 로컬 실행

프로젝트를 다운로드 받은 후, HTML 파일을 브라우저에서 직접 열거나 로컬 서버를 실행하세요.

```bash
# Python 내장 서버 사용
python -m http.server 8000

# Node.js http-server 사용
npx http-server
```

그 후 브라우저에서 `http://localhost:8000` 접속

### 2. GitHub Pages 배포

1. GitHub 저장소에 코드를 푸시
2. Settings > Pages 메뉴로 이동
3. Source를 `main` 브랜치로 설정
4. 배포 완료!

## 📁 프로젝트 구조

```
01_VC_BASICWEB/
├── index.html              # 메인 HTML 파일
├── styles.css              # 스타일시트
├── script.js               # JavaScript 파일
├── terms.html              # 이용약관 페이지
├── privacy.html            # 개인정보처리방침 페이지
├── README.md               # 프로젝트 문서
├── TEST_REPORT.md          # 테스트 리포트
├── 웹사이트기획안.markdown  # 웹사이트 기획안
└── .playwright-mcp/        # 테스트 스크린샷 디렉토리
```

## ✨ 주요 기능 설명

### 스크롤 애니메이션

Intersection Observer API를 사용하여 스크롤 시 부드러운 fade-up 애니메이션을 구현했습니다.

```javascript
const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
        }
    });
}, {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
});
```

### 폼 유효성 검증

실시간 유효성 검증으로 사용자 경험을 개선했습니다.

- **이름**: 2자 이상
- **이메일**: 이메일 형식 검증
- **연락처**: 한국 전화번호 형식 (010-XXXX-XXXX)
- **관심 서비스**: 필수 선택
- **문의 내용**: 10자 이상
- **개인정보 동의**: 필수 체크

### 전화번호 자동 포맷팅

사용자가 전화번호를 입력하면 자동으로 하이픈(-)을 추가합니다.

```javascript
// 입력: 01012345678
// 결과: 010-1234-5678
```

### Scroll to Top 버튼

300px 이상 스크롤 시 자동으로 나타나는 맨 위로 버튼을 제공합니다.

## 📱 반응형 디자인

Mobile-first 접근 방식으로 모든 디바이스에서 최적의 사용자 경험을 제공합니다.

- **모바일**: 단일 컬럼 레이아웃
- **태블릿**: 2컬럼 그리드
- **데스크톱**: 다중 컬럼 그리드

## 🎯 성능 최적화

- CSS 애니메이션 하드웨어 가속
- Intersection Observer로 효율적인 스크롤 감지
- 이미지 lazy loading 준비
- 최소한의 외부 의존성

## 🔧 커스터마이징

### 색상 변경

`styles.css` 파일의 `:root` 섹션에서 CSS 변수를 수정하세요.

```css
:root {
    --primary-dark: #YOUR_COLOR;
    --primary: #YOUR_COLOR;
    /* ... */
}
```

### 섹션 추가/제거

`index.html`에서 `<section>` 요소를 추가하거나 제거하세요. 클래스명 규칙을 따라주세요.

### 애니메이션 조정

`styles.css`의 애니메이션 섹션에서 속도와 타이밍을 조정할 수 있습니다.

## 📞 문의

- 이메일: contact@formeai.org
- 전화: 1588-0000
- 운영시간: 평일 09:00 - 18:00
- 카카오톡: @포미서비스

## 📄 라이선스

© 2025 포미서비스. All rights reserved.

---

**Made with ❤️ by 포미서비스**


