alter table public.car_registrations
  add column if not exists memo text,
  add column if not exists car_order smallint;

alter table public.car_registrations enable row level security;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'car_registrations'
      and policyname = 'anon can insert car registrations'
  ) then
    create policy "anon can insert car registrations"
    on public.car_registrations
    for insert
    to anon
    with check (true);
  end if;
end $$;
