#!/bin/bash

# 포미서비스 랜딩 페이지 - 원클릭 배포 스크립트
# GitHub Personal Access Token을 사용한 자동 배포

set -e  # 오류 발생 시 즉시 중단

echo "=========================================="
echo "🚀 포미서비스 랜딩 페이지 - GitHub 배포"
echo "=========================================="
echo ""

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# GitHub 사용자명 입력
echo -e "${YELLOW}GitHub 사용자명을 입력하세요:${NC}"
read -r GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo -e "${RED}❌ 오류: GitHub 사용자명이 비어있습니다.${NC}"
    exit 1
fi

# Repository 이름
REPO_NAME="formeai-landing"

echo ""
echo "=========================================="
echo "📋 배포 정보:"
echo "  GitHub 사용자: $GITHUB_USERNAME"
echo "  Repository: $REPO_NAME"
echo "  배포 URL: https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
echo "=========================================="
echo ""

# GitHub Personal Access Token 확인
echo -e "${YELLOW}GitHub Personal Access Token이 있으신가요? (y/n)${NC}"
echo "(없으면 수동 배포 안내를 보여드립니다)"
read -r HAS_TOKEN

if [ "$HAS_TOKEN" = "y" ] || [ "$HAS_TOKEN" = "Y" ]; then
    echo ""
    echo -e "${YELLOW}GitHub Personal Access Token을 입력하세요:${NC}"
    echo "(입력한 내용은 화면에 표시되지 않습니다)"
    read -rs GITHUB_TOKEN
    echo ""
    
    if [ -z "$GITHUB_TOKEN" ]; then
        echo -e "${RED}❌ 오류: Token이 비어있습니다.${NC}"
        exit 1
    fi
    
    echo ""
    echo "🔄 1/3: GitHub에 Repository 생성 중..."
    
    # Repository 생성
    CREATE_RESULT=$(curl -s -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        https://api.github.com/user/repos \
        -d "{\"name\":\"$REPO_NAME\",\"description\":\"포미서비스 AI SNS 마케팅 랜딩 페이지\",\"homepage\":\"https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/\",\"private\":false}")
    
    # 결과 확인
    if echo "$CREATE_RESULT" | grep -q "\"name\":\"$REPO_NAME\""; then
        echo -e "${GREEN}✅ Repository 생성 성공!${NC}"
    elif echo "$CREATE_RESULT" | grep -q "already exists"; then
        echo -e "${YELLOW}⚠️  Repository가 이미 존재합니다. 계속 진행합니다.${NC}"
    else
        echo -e "${RED}❌ Repository 생성 실패${NC}"
        echo "$CREATE_RESULT" | grep -o '"message":"[^"]*"' || echo "알 수 없는 오류"
        echo ""
        echo "수동 배포를 진행하시겠습니까? (y/n)"
        read -r MANUAL
        if [ "$MANUAL" != "y" ] && [ "$MANUAL" != "Y" ]; then
            exit 1
        fi
    fi
    
    echo ""
    echo "🔄 2/3: GitHub에 코드 푸시 중..."
    
    # 기존 origin 제거 (있다면)
    git remote remove origin 2>/dev/null || true
    
    # 원격 저장소 추가 및 푸시
    git remote add origin "https://${GITHUB_TOKEN}@github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
    
    if git push -u origin main; then
        echo -e "${GREEN}✅ 코드 푸시 성공!${NC}"
    else
        echo -e "${RED}❌ 푸시 실패${NC}"
        exit 1
    fi
    
    echo ""
    echo "🔄 3/3: GitHub Pages 활성화 중..."
    
    # GitHub Pages 활성화 (약간의 지연 후)
    sleep 2
    PAGES_RESULT=$(curl -s -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/${GITHUB_USERNAME}/${REPO_NAME}/pages" \
        -d '{"source":{"branch":"main","path":"/"}}')
    
    if echo "$PAGES_RESULT" | grep -q "\"status\":\"built\"" || echo "$PAGES_RESULT" | grep -q "\"status\":\"queued\""; then
        echo -e "${GREEN}✅ GitHub Pages 활성화 성공!${NC}"
    elif echo "$PAGES_RESULT" | grep -q "already deployed"; then
        echo -e "${YELLOW}⚠️  GitHub Pages가 이미 활성화되어 있습니다.${NC}"
    else
        echo -e "${YELLOW}⚠️  GitHub Pages 자동 활성화 실패 - 수동으로 설정해주세요${NC}"
        echo "   Settings > Pages > Source: main, / (root) > Save"
    fi
    
    echo ""
    echo "=========================================="
    echo -e "${GREEN}🎉 배포 완료!${NC}"
    echo "=========================================="
    echo ""
    echo "약 1-2분 후 다음 주소에서 사이트를 확인할 수 있습니다:"
    echo ""
    echo -e "${GREEN}🌍 https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/${NC}"
    echo ""
    echo "Repository: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
    echo "Settings: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
    echo ""
    
else
    # Token이 없는 경우 - 수동 배포 안내
    echo ""
    echo "=========================================="
    echo "📝 수동 배포 안내"
    echo "=========================================="
    echo ""
    echo "다음 단계를 따라주세요:"
    echo ""
    echo "1️⃣  브라우저에서 GitHub Repository 생성:"
    echo "   https://github.com/new"
    echo ""
    echo "   설정:"
    echo "   - Repository name: $REPO_NAME"
    echo "   - Public 선택"
    echo "   - ❌ 모든 체크박스 해제"
    echo "   - 'Create repository' 클릭"
    echo ""
    echo "2️⃣  아래 명령어 실행:"
    echo ""
    echo -e "${GREEN}   git remote add origin https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git${NC}"
    echo -e "${GREEN}   git push -u origin main${NC}"
    echo ""
    echo "3️⃣  GitHub Pages 활성화:"
    echo "   https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
    echo ""
    echo "   설정:"
    echo "   - Source: Branch 'main', Folder '/ (root)'"
    echo "   - Save 클릭"
    echo ""
    echo "4️⃣  완료! 사이트 확인:"
    echo "   https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
    echo ""
    echo "=========================================="
    echo ""
    echo "💡 Tip: Personal Access Token 생성:"
    echo "   https://github.com/settings/tokens"
    echo "   (repo, workflow 권한 필요)"
    echo ""
fi

echo ""
echo "감사합니다! 🚀"

