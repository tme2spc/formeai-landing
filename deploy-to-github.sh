#!/bin/bash

echo "=========================================="
echo "포미서비스 랜딩 페이지 - GitHub 배포 스크립트"
echo "=========================================="
echo ""

# 사용자에게 GitHub 사용자명 입력 받기
echo "GitHub 사용자명을 입력하세요:"
read -r GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "❌ 오류: GitHub 사용자명이 비어있습니다."
    exit 1
fi

# Repository 이름 입력 받기
echo ""
echo "Repository 이름을 입력하세요 (기본값: formeai-landing):"
read -r REPO_NAME

if [ -z "$REPO_NAME" ]; then
    REPO_NAME="formeai-landing"
fi

echo ""
echo "=========================================="
echo "설정 확인:"
echo "  GitHub 사용자명: $GITHUB_USERNAME"
echo "  Repository 이름: $REPO_NAME"
echo "  배포 URL: https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
echo "=========================================="
echo ""

# 확인 메시지
echo "계속하시겠습니까? (y/n)"
read -r CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo "❌ 배포가 취소되었습니다."
    exit 0
fi

echo ""
echo "📋 1단계: GitHub에서 Repository 생성"
echo "----------------------------------------"
echo "브라우저에서 다음 URL을 열어주세요:"
echo "https://github.com/new"
echo ""
echo "Repository 설정:"
echo "  - Repository name: $REPO_NAME"
echo "  - Description: 포미서비스 AI SNS 마케팅 랜딩 페이지"
echo "  - Public 선택"
echo "  - ❌ README, .gitignore, license 모두 체크 해제"
echo ""
echo "Repository를 생성하셨습니까? (y/n)"
read -r REPO_CREATED

if [ "$REPO_CREATED" != "y" ] && [ "$REPO_CREATED" != "Y" ]; then
    echo "❌ Repository를 먼저 생성해주세요."
    exit 1
fi

echo ""
echo "🔗 2단계: 원격 저장소 연결"
echo "----------------------------------------"

# 기존 origin이 있으면 제거
if git remote get-url origin &> /dev/null; then
    echo "기존 origin 제거 중..."
    git remote remove origin
fi

# HTTPS 또는 SSH 선택
echo "연결 방식을 선택하세요:"
echo "  1) HTTPS (추천)"
echo "  2) SSH"
read -r CONNECTION_TYPE

if [ "$CONNECTION_TYPE" = "2" ]; then
    REMOTE_URL="git@github.com:${GITHUB_USERNAME}/${REPO_NAME}.git"
else
    REMOTE_URL="https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
fi

echo "원격 저장소 추가 중: $REMOTE_URL"
git remote add origin "$REMOTE_URL"

if [ $? -eq 0 ]; then
    echo "✅ 원격 저장소 연결 성공"
else
    echo "❌ 원격 저장소 연결 실패"
    exit 1
fi

echo ""
echo "📤 3단계: GitHub에 푸시"
echo "----------------------------------------"
echo "GitHub에 코드를 업로드합니다..."

git push -u origin main

if [ $? -eq 0 ]; then
    echo "✅ 푸시 성공!"
else
    echo "❌ 푸시 실패"
    echo ""
    echo "인증이 필요할 수 있습니다. 다음을 시도해보세요:"
    echo "  1) GitHub Personal Access Token 생성"
    echo "  2) 토큰을 비밀번호로 사용하여 푸시"
    exit 1
fi

echo ""
echo "🌐 4단계: GitHub Pages 설정"
echo "----------------------------------------"
echo "브라우저에서 다음 URL을 열어주세요:"
echo "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
echo ""
echo "설정 방법:"
echo "  1. 'Source' 섹션 찾기"
echo "  2. Branch: 'main' 선택"
echo "  3. Folder: '/ (root)' 선택"
echo "  4. 'Save' 버튼 클릭"
echo ""
echo "GitHub Pages를 설정하셨습니까? (y/n)"
read -r PAGES_CONFIGURED

if [ "$PAGES_CONFIGURED" = "y" ] || [ "$PAGES_CONFIGURED" = "Y" ]; then
    echo ""
    echo "=========================================="
    echo "🎉 배포 완료!"
    echo "=========================================="
    echo ""
    echo "약 1-2분 후 다음 주소에서 사이트를 확인할 수 있습니다:"
    echo ""
    echo "  🌍 https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
    echo ""
    echo "브라우저에서 위 URL을 열어보세요!"
    echo ""
else
    echo ""
    echo "⚠️  GitHub Pages 설정을 완료해주세요."
    echo "설정 후 다음 주소에서 사이트를 확인할 수 있습니다:"
    echo "  https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
fi

echo ""
echo "=========================================="
echo "📋 추가 정보"
echo "=========================================="
echo "Repository URL: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
echo "Settings URL: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings"
echo "Pages URL: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
echo ""
echo "감사합니다! 🚀"

