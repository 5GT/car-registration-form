begin;

revoke all on table public.car_registrations from anon;
revoke all on table public.car_registrations from authenticated;

grant insert on table public.car_registrations to anon;
grant select, insert, update, delete on table public.car_registrations to authenticated;

drop policy if exists "anon can insert car registrations" on public.car_registrations;
drop policy if exists "anon_insert_only" on public.car_registrations;
drop policy if exists "admin_select_only" on public.car_registrations;
drop policy if exists "admin_insert_only" on public.car_registrations;
drop policy if exists "admin_update_only" on public.car_registrations;
drop policy if exists "admin_delete_only" on public.car_registrations;

alter table public.car_registrations enable row level security;

create policy "anon_insert_only"
on public.car_registrations
for insert
to anon
with check (true);

create policy "admin_select_only"
on public.car_registrations
for select
to authenticated
using ((auth.jwt() ->> 'email') = 'parkl4562@naver.com');

create policy "admin_insert_only"
on public.car_registrations
for insert
to authenticated
with check ((auth.jwt() ->> 'email') = 'parkl4562@naver.com');

create policy "admin_update_only"
on public.car_registrations
for update
to authenticated
using ((auth.jwt() ->> 'email') = 'parkl4562@naver.com')
with check ((auth.jwt() ->> 'email') = 'parkl4562@naver.com');

create policy "admin_delete_only"
on public.car_registrations
for delete
to authenticated
using ((auth.jwt() ->> 'email') = 'parkl4562@naver.com');

commit;
