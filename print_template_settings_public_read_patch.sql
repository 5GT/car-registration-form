grant select on public.print_template_settings to anon;
grant select on public.print_template_settings to authenticated;

drop policy if exists "anon can read print template settings" on public.print_template_settings;

create policy "anon can read print template settings"
on public.print_template_settings
for select
to anon
using (true);
