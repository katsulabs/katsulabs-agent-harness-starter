# Contract Handoff — TB-101

## API 변경

- `GET /api/users` — 페이지네이션 `?page=&size=`

## DTO

```json
{ "id": "uuid", "name": "string", "email": "string" }
```

## DB (해당 시)

- migration: `V00x__users.sql`
- 호환성: additive only / rollback: [N/A 또는 절차]

## Backend TODO

- [ ] Controller + Service + Repository

## Frontend TODO

- [ ] API client 타입 반영
- [ ] UserList 컴포넌트

## Breaking change

없음
