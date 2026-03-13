alter table public.car_registrations
  add column if not exists household_notice boolean not null default false;
