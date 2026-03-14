create or replace function public.enforce_car_registrations_household_limit()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  current_count integer;
begin
  select count(*)
    into current_count
  from public.car_registrations
  where building_number = new.building_number
    and unit_number = new.unit_number;

  if current_count >= 3 then
    raise exception '세대당 차량은 최대 3대까지 등록 가능합니다.';
  end if;

  return new;
end;
$$;

drop trigger if exists trg_car_registrations_household_limit on public.car_registrations;

create trigger trg_car_registrations_household_limit
before insert on public.car_registrations
for each row
execute function public.enforce_car_registrations_household_limit();
