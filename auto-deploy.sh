#!/bin/bash

# 포미서비스 랜딩 페이지 - 자동 배포 스크립트
# GitHub 사용자명: tme2spc

GITHUB_USERNAME="tme2spc"
REPO_NAME="formeai-landing"

echo "=========================================="
echo "🚀 포미서비스 랜딩 페이지 - GitHub 배포"
echo "=========================================="
echo ""
echo "GitHub 사용자: $GITHUB_USERNAME"
echo "Repository: $REPO_NAME"
echo "배포 URL: https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
echo ""
echo "=========================================="
echo ""

# 기존 origin 제거 (있다면)
git remote remove origin 2>/dev/null || true

# 원격 저장소 추가
echo "🔗 원격 저장소 추가 중..."
git remote add origin "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

echo ""
echo "=========================================="
echo "📝 다음 단계를 진행해주세요:"
echo "=========================================="
echo ""
echo "1️⃣  GitHub에서 Repository 생성:"
echo "   👉 https://github.com/new"
echo ""
echo "   설정:"
echo "   - Repository name: ${REPO_NAME}"
echo "   - Description: 포미서비스 AI SNS 마케팅 랜딩 페이지"
echo "   - Public 선택"
echo "   - ❌ README, .gitignore, license 모두 체크 해제"
echo "   - 'Create repository' 버튼 클릭"
echo ""
echo "2️⃣  Repository를 생성하셨으면 아래 명령어를 실행하세요:"
echo ""
echo "   git push -u origin main"
echo ""
echo "3️⃣  GitHub Pages 활성화:"
echo "   👉 https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
echo ""
echo "   설정:"
echo "   - Source: Branch 'main' 선택"
echo "   - Folder: '/ (root)' 선택"
echo "   - 'Save' 버튼 클릭"
echo ""
echo "4️⃣  완료! 약 1-2분 후 사이트 확인:"
echo "   🌍 https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
echo ""
echo "=========================================="
echo ""

