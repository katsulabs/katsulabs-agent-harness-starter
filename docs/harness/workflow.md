# 하네스 워크플로

## 원칙

- `main`에 기능 커밋 금지
- 기능당 worktree 1개
- PR 전 문서 품질 게이트 통과 (`.cursor/skills/` 참고)
- 머지는 no-ff

## 일일 흐름

1. 최신 `main` 기준으로 worktree 생성
2. 구현 및 검증 스킬 실행
3. PR 생성 및 리뷰
4. 승인 후 `main`에 no-ff 머지

## Hook 실패 대체 런북

Hook이 비활성/실패하면 수동으로 단계 전환합니다.

1. 태그를 유지해 다음 Sub-agent를 메인이 직접 분배
2. 직전 산출물(계약 메모, 검증 결과) 전달
3. QA 전환 전 검증 스킬 재실행
4. PR 본문에 fallback 사용 사유 기록

## 운영 지표 (선택)

- PR Lead Time
- Reopen Rate
- Handoff Failure
