# car-registration-form

아파트 입주민 차량등록 사전접수와 관리사무소 확인 업무를 위한 프로젝트입니다.

## 목적
- 입주민이 미리 차량등록 신청서를 작성하게 해 현장 혼잡을 줄입니다.
- 관리사무소 직원이 방문 시 신청 내역을 조회하고 서류를 확인한 뒤 차량등록카드(스티커)를 발급할 수 있게 합니다.
- 공개 페이지와 관리자 기능을 분리하되, Supabase 프로젝트는 하나만 사용합니다.

## 현재 파일
- `index.html`: 메인 진입 페이지
- `resident.html`: 입주민 차량등록 신청 페이지
- `external.html`: 외부 차량 등록 페이지
- `complete.html`: 신청 완료 안내 페이지
- `parkreeks-logo.png`: 공용 로고 이미지
- `STAFF_GUIDE.md`: 직원용 사용 안내 및 업무 절차 문서

## 보안 구조
- 입주민 페이지는 로그인 없이 사용합니다.
- 입주민은 `insert`만 가능합니다.
- 관리자 페이지는 별도 로그인 구조를 사용합니다.
- 로그인한 관리자만 조회, 수정, 삭제가 가능합니다.

## 참고 SQL
- `supabase_rls_plan.sql`: 권한 분리 정책 참고용 SQL
- `car_registrations_public_patch.sql`: 공개 등록 관련 보정 SQL
- `car_registrations_household_limit_patch.sql`: 세대당 3대 제한 트리거 SQL
- `car_registrations_compact_discount_patch.sql`: 경차 할인 컬럼 추가 SQL
- `car_registrations_household_notice_patch.sql`: 세대알림 컬럼 추가 SQL
- `external_car_registrations.sql`: 외부 차량 테이블 관련 SQL

## 메모
- 브라우저에 `service_role` 키를 넣으면 안 됩니다.
- 입주민 테스트는 시크릿 모드에서 진행하는 것이 안전합니다.
- 관리자 기능은 실제 관리자 페이지 기준으로 운영합니다.
