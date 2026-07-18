# TODO

## 활성

| 티켓 | 상태 | DoD |
|------|------|-----|
| — | — | 활성 티켓 없음 |

## 완료

| 티켓 | DoD |
|------|-----|
| TB-027 | 루트 README에 멀티에이전트 섹션 추가 (관심사→장치 표 + introduction·status-schema 링크) (PR #23) |
| TB-026 | .gitignore에 .DS_Store 추가 (PR #21) |
| TB-025 | 초기 진단 리뷰(multi-agent-readiness-review.md)를 docs/harness/로 이관 + 이력 주석 (PR #19) |
| TB-024 | introduction.md 멀티에이전트 3-Phase(동시·협업·조정) 섹션 + 명령·검증 표 반영 (PR #17) |
| TB-023 | 오케스트레이션 스캐폴딩: dispatch-plan(전 역할 프롬프트+상태 스켈레톤)·collect-handoff(전 역할 done 게이트) (.sh+.ps1), 완료 상태 예시, harness-smoke·매니페스트·playbook 반영 (PR #15) |
| TB-022 | 공유 상태 채널: status-schema·예시, validate-status 린터 (.sh+.ps1), validate-handoff status 스킵, playbook 구두전달→상태파일 append, harness-smoke·매니페스트 반영 (PR #13) |
| TB-021 | 멀티에이전트 동시 실행 안전성: 1워크트리=1인스턴스·todo 브랜치-한정 규약, eval 산출물 티켓 경로 격리 (.sh+.ps1), 기존 링크·AL-09/AL-13 fixture·verify-dispatch CI detached-HEAD 폴백 수정 (PR #11) |
| TB-020 | how-to-use, bootstrap-prompts, README 학습 순서, multi-agent-dispatch 예시 |
| TB-016 | 커밋/todo/PR 게이트, 역할 스킬, presets, first-ticket, pre-commit handoff |
| TB-015 | LLM auto-score, cost-summary, verify-dispatch, secrets-rotation |
| TB-014 | LLM eval 세션·채점, duration 리포트, harness-smoke 연동 |
| TB-013 | sample TB-101, dispatch 스킬, summarize-eval, secrets·LLM eval 가이드 |
| TB-012 | handoff 린터, agent-eval runner, eval 리포트, playbook/PR 게이트 |
| TB-011 | harness-smoke eval, handoff 스키마, 서브에이전트 디스패치, MCP 가이드, run-eval 폴백 |
| TB-010 | macOS/Windows 쉘 이중화 (.sh + .ps1), pwsh 7.4+ 버전·설치 문서, CI OS matrix |

| 티켓 | DoD |
|------|-----|
| TB-001 | 문서 한글화, 스킬 추가, 하네스 절감 |
| TB-002 | 토큰 효율 (규칙·스킬·playbook 통합) |
| TB-003 | validate 스크립트, CI, qa 규칙, AGENTS.md |
| TB-009 | 3세대: AGENTS 계약, TEMPLATE, eval/MCP, Skills, 코드 샘플 |
| TB-007 | Backend/Frontend 코드 영역 규칙 복원 |
| TB-006 | Public 전환, branch protection 활성화 |
| TB-005 | CI main 트리거, operations.md, pre-commit 수정, PR #5 머지 |

## 보류

| 항목 | 비고 |
|------|------|
| Vault/KMS 연동 | 배포 환경별 별도 설계 |
