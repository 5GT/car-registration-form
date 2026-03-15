create table if not exists public.print_template_settings (
  template_key text primary key,
  content jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.print_template_settings enable row level security;

drop policy if exists "authenticated can read print template settings" on public.print_template_settings;
drop policy if exists "authenticated can insert print template settings" on public.print_template_settings;
drop policy if exists "authenticated can update print template settings" on public.print_template_settings;
drop policy if exists "anon can read print template settings" on public.print_template_settings;

grant select on public.print_template_settings to anon;
grant select, insert, update on public.print_template_settings to authenticated;

create policy "authenticated can read print template settings"
on public.print_template_settings
for select
to authenticated
using (true);

create policy "anon can read print template settings"
on public.print_template_settings
for select
to anon
using (true);

create policy "authenticated can insert print template settings"
on public.print_template_settings
for insert
to authenticated
with check (true);

create policy "authenticated can update print template settings"
on public.print_template_settings
for update
to authenticated
using (true)
with check (true);

insert into public.print_template_settings (template_key, content)
values
(
  'resident',
  '{
    "registrationGuide": "세대당 차량은 최대 3대까지 등록할 수 있습니다.\n차량등록카드(주차스티커)는 차량 내부 조수석 하단 부착이 원칙이며, 외부에 양도, 판매, 대여할 수 없습니다.\n단지 내에서는 서행(10km/h 이하) 및 보행자 우선 원칙을 준수해야 합니다.\n주차관리 규정을 위반할 경우 경고 및 관리규정에 따른 조치가 적용될 수 있습니다.",
    "cancellationGuide": "해지와 동시에 해당 차량의 주차 등록 권한은 종료됩니다.\n등록카드는 반드시 반납해 주시기 바랍니다.\n분실 또는 미반납 시 관리사무소로 확인해 주시기 바랍니다.",
    "consentText": "본인은 상기 안내 내용과 단지 주차관리 규정을 확인하였으며, 이를 준수할 것에 동의합니다.",
    "ownershipDocs": {
      "본인명의": {
        "docs": "자동차등록증, 실거주 확인 서류(주민등록등본 등 주소 확인 가능 서류)",
        "note": "차량 소유자와 세대 실거주 여부를 확인합니다."
      },
      "가족명의": {
        "docs": "자동차등록증, 가족관계증명서, 실거주 확인 서류(주민등록등본 등 주소 확인 가능 서류)",
        "note": "가족관계 및 세대 실거주 여부를 확인합니다."
      },
      "렌트": {
        "docs": "렌트/리스 계약서, 실거주 확인 서류(주민등록등본 등 주소 확인 가능 서류)",
        "note": "계약자 및 세대 실거주 여부를 확인합니다."
      },
      "회사차량": {
        "docs": "자동차등록증, 재직증명서(또는 건강보험증), 실거주 확인 서류(주민등록등본 등 주소 확인 가능 서류)",
        "note": "재직 여부 및 세대 실거주 여부를 확인합니다."
      }
    },
    "categoryGuides": {
      "전기차": "전기차 충전구역 이용 시 관리기준을 준수해야 합니다.",
      "경차할인적용": "경차는 경차 전용구역에 주차해야 하며, 관리기준에 따라 할인 적용 여부가 유지됩니다.",
      "대형": "대형 차량은 관리사무소 확인 후 기준에 따라 등록됩니다.",
      "장애인주차표지": "장애인주차표지 관련 서류와 표지를 확인합니다."
    }
  }'::jsonb
),
(
  'external',
  '{
    "registrationGuide": "높이 2.7m 초과 차량은 지하 출입이 불가 합니다.\n공동현관 마스터키 발급은 택배, 배송차량만 가능합니다.",
    "cancellationGuide": "해지와 동시에 해당 차량의 출입 등록 권한은 종료됩니다.\n발급된 마스터키가 있는 경우 반드시 반납해 주시기 바랍니다.\n미반납 또는 분실 시 관리사무소로 확인해 주시기 바랍니다.",
    "consentText": "본인은 상기 내용이 사실과 같음을 확인하며, 단지 운영 기준에 따라 출입 등록이 조정될 수 있음에 동의합니다.",
    "officeDocText": "자동차등록증, 사업자등록증"
  }'::jsonb
)
on conflict (template_key) do update
set content = excluded.content,
    updated_at = now();
