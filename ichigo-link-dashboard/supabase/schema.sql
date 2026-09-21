-- 1) Jalankan SQL ini di Supabase SQL Editor.
create table if not exists public.admin_users (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.training_links (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  slug text unique,
  url text not null,
  category text not null default 'Lainnya',
  description text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.admin_users enable row level security;
alter table public.training_links enable row level security;

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = public
as $$ select exists(select 1 from public.admin_users where user_id=auth.uid()); $$;

drop policy if exists "admin own row" on public.admin_users;
create policy "admin own row" on public.admin_users for select using (user_id=auth.uid());

drop policy if exists "admins manage links" on public.training_links;
create policy "admins manage links" on public.training_links for all using (public.is_admin()) with check (public.is_admin());

create or replace function public.set_updated_at() returns trigger language plpgsql as $$ begin new.updated_at=now(); return new; end; $$;
drop trigger if exists training_links_updated_at on public.training_links;
create trigger training_links_updated_at before update on public.training_links for each row execute function public.set_updated_at();

-- Setelah membuat user admin di Authentication > Users, jalankan:
-- insert into public.admin_users(user_id) values ('UUID_USER_ADMIN');
