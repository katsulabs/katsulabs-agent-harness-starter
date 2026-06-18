---
name: worktree-setup
description: 기능 티켓용 git worktree 생성·제거. 병렬 티켓 착수 시 실행한다.
disable-model-invocation: true
---

# Worktree Setup

## 생성

```bash
git fetch origin main
git worktree add ../.worktrees/TB-{id}-{name} -b feature/TB-{id}-{name} origin/main
```

`.worktrees/`는 `.gitignore`에 추가.

## 제거

```bash
git worktree remove ../.worktrees/TB-{id}-{name}
git branch -d feature/TB-{id}-{name}   # 머지 후
```

## 검증

- main이 아닌 브랜치에서 작업
- 티켓당 worktree 1개
