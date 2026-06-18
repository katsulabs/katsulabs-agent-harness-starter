## 요약

<!-- 무엇을 왜 -->

## 검증 계획

- [ ] `pwsh scripts/validate-harness.ps1 -Pr` 통과
- [ ] `pwsh scripts/run-eval.ps1` 통과 (또는 SKIP — 미설정 시)
- [ ] CI `validate` + `test` green
- [ ] `main` 직접 커밋 없음

## 테스트 게이트

- [ ] Backend test passed (N/A 가능)
- [ ] Frontend test passed (N/A 가능)
- [ ] Contract/API 변경 시 핸드오프 메모 첨부 (N/A 가능)

## 하드 게이트

- [ ] 티켓 ID·범위 명시
- [ ] 브랜치 규칙 준수
- [ ] DB/migration 변경 시 호환성·rollback 메모 (N/A 가능)
- [ ] Hook fallback 시 사유 기록 (N/A 가능)
