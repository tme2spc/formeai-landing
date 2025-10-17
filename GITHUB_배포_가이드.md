# GitHub 배포 가이드

## 📋 준비 사항
현재 Git 저장소가 초기화되어 있고, 모든 파일이 커밋되어 있습니다.

## 🚀 GitHub에 배포하는 방법

### 방법 1: GitHub 웹사이트에서 직접 생성 (권장)

#### 1단계: GitHub에 새 Repository 생성

1. https://github.com/new 접속
2. Repository 정보 입력:
   - **Repository name**: `formeai-landing` (또는 원하는 이름)
   - **Description**: `포미서비스 AI SNS 마케팅 랜딩 페이지`
   - **Public** 선택 (GitHub Pages를 무료로 사용하려면 Public 필요)
   - **Initialize this repository with:**
     - ❌ README 체크 해제
     - ❌ .gitignore 체크 해제
     - ❌ license 체크 해제
3. "Create repository" 클릭

#### 2단계: 로컬 저장소를 GitHub에 연결

생성된 repository 페이지에서 "…or push an existing repository from the command line" 섹션의 명령어를 사용합니다.

터미널에서 다음 명령어를 실행하세요 (YOUR_USERNAME을 실제 GitHub 사용자명으로 변경):

```bash
cd /home/tmetospc/cursor_project/01_VC_BASICWEB
git remote add origin https://github.com/YOUR_USERNAME/formeai-landing.git
git push -u origin main
```

또는 SSH를 사용하는 경우:

```bash
cd /home/tmetospc/cursor_project/01_VC_BASICWEB
git remote add origin git@github.com:YOUR_USERNAME/formeai-landing.git
git push -u origin main
```

#### 3단계: GitHub Pages 설정

1. Repository 페이지로 이동
2. "Settings" 탭 클릭
3. 왼쪽 메뉴에서 "Pages" 클릭
4. "Source" 섹션에서:
   - Branch: `main` 선택
   - Folder: `/ (root)` 선택
5. "Save" 버튼 클릭

#### 4단계: 배포 완료!

약 1-2분 후, 다음 주소에서 사이트를 확인할 수 있습니다:
```
https://YOUR_USERNAME.github.io/formeai-landing/
```

---

### 방법 2: GitHub CLI 사용 (gh CLI 설치 필요)

#### 1단계: GitHub CLI 설치

```bash
sudo apt install gh -y
```

#### 2단계: GitHub 인증

```bash
gh auth login
```

브라우저를 통한 인증을 선택하고 안내를 따릅니다.

#### 3단계: Repository 생성 및 푸시

```bash
cd /home/tmetospc/cursor_project/01_VC_BASICWEB
gh repo create formeai-landing --public --source=. --remote=origin --push
```

#### 4단계: GitHub Pages 활성화

```bash
gh api repos/{owner}/formeai-landing/pages --method POST -f source[branch]=main -f source[path]=/
```

---

### 방법 3: Git 명령어로 수동 설정

이미 repository를 만들었다면:

```bash
cd /home/tmetospc/cursor_project/01_VC_BASICWEB

# 원격 저장소 추가 (URL을 실제 repository URL로 변경)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git

# 푸시
git push -u origin main
```

---

## 📝 현재 상태

✅ Git 저장소 초기화 완료  
✅ 모든 파일 커밋 완료 (commit: df8ceed)  
✅ 브랜치: main  
⏳ GitHub 원격 저장소 연결 대기 중  
⏳ GitHub Pages 설정 대기 중  

## 📂 커밋된 파일 목록

- index.html (메인 페이지)
- styles.css (스타일시트)
- script.js (JavaScript)
- privacy.html (개인정보처리방침)
- terms.html (이용약관)
- README.md (프로젝트 설명)
- TEST_REPORT.md (테스트 리포트)
- 최종_업데이트_내역.md (업데이트 내역)
- 웹사이트기획안.markdown (기획안)
- .gitignore (Git 제외 파일)

## 🔧 배포 후 확인사항

### 1. 사이트 접속 테스트
```
https://YOUR_USERNAME.github.io/formeai-landing/
```

### 2. 모든 페이지 확인
- ✅ 메인 페이지 (index.html)
- ✅ 이용약관 (terms.html)
- ✅ 개인정보처리방침 (privacy.html)

### 3. 반응형 테스트
- ✅ 모바일 화면
- ✅ 태블릿 화면
- ✅ 데스크톱 화면

### 4. 기능 테스트
- ✅ 네비게이션 링크
- ✅ CTA 버튼
- ✅ 폼 제출
- ✅ 스크롤 애니메이션

## 🎯 배포 후 최적화 권장사항

### 1. 커스텀 도메인 설정 (선택사항)

GitHub Pages에서 커스텀 도메인을 설정할 수 있습니다:

1. Repository Settings > Pages
2. "Custom domain" 섹션에 도메인 입력 (예: www.formeai.org)
3. DNS 설정에서 CNAME 레코드 추가:
   ```
   CNAME: www.formeai.org -> YOUR_USERNAME.github.io
   ```

### 2. HTTPS 강제 적용

Repository Settings > Pages에서 "Enforce HTTPS" 체크박스 활성화

### 3. Google Analytics 추가

index.html의 `<head>` 섹션에 Google Analytics 코드 추가

### 4. SEO 최적화

- sitemap.xml 생성
- robots.txt 추가
- Open Graph 메타 태그 추가

## 📞 문의

배포 중 문제가 발생하면:
- GitHub 이메일: contact@formeai.org
- GitHub Docs: https://docs.github.com/pages

## 🎉 다음 단계

배포가 완료되면:
1. ✅ 사이트 URL 확인
2. ✅ 모든 기능 테스트
3. ✅ 모바일/데스크톱 확인
4. ✅ 팀에 공유
5. ✅ SNS에 홍보

---

**준비 완료!** GitHub에 repository를 만들고 위의 명령어를 실행하면 즉시 배포됩니다! 🚀

