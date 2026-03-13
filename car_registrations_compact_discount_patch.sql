alter table public.car_registrations
  add column if not exists compact_discount boolean not null default false;
