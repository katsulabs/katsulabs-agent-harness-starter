# Harness Baseline

새 프로젝트 기본 하네스 기준입니다.

## Core

- main 보호 + worktree 강제
- no-ff merge
- 역할 분리 (Main/Contract/Backend/Frontend/QA)
- 테스트 게이트 (backend + frontend)

## First Turn Checklist

- [ ] ticket/DoD 확인
- [ ] worktree/branch 준비
- [ ] 태그 기반 dispatch
- [ ] hook fallback 필요 여부 확인

## PR Hard Gates

- [ ] ticket 목적 명시
- [ ] 역할 경계 위반 없음
- [ ] backend/frontend 테스트 결과 첨부
- [ ] DB 변경 시 호환성 메모 포함
