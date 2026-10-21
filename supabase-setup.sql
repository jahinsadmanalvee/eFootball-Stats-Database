-- eFootball Stats Database: safe schema/policy setup
-- IMPORTANT: replace YOUR_ADMIN_EMAIL@example.com below with the exact email
-- of the admin account you create in Supabase Authentication before running.

alter table public.players
  add column if not exists position text not null default 'Strikers'' / Second Strikers'' Stats',
  add column if not exists matches_played integer not null default 0,
  add column if not exists goals integer not null default 0,
  add column if not exists assists integer not null default 0,
  add column if not exists card_image_url text,
  add column if not exists player_image_url text,
  add column if not exists shots_faced integer not null default 0,
  add column if not exists goals_saved integer not null default 0,
  add column if not exists goals_conceded integer not null default 0,
  add column if not exists clean_sheets integer not null default 0,
  add column if not exists penalties_faced integer not null default 0,
  add column if not exists penalties_saved integer not null default 0,
  add column if not exists updated_at timestamptz not null default now();

-- Upsert by player name requires a unique constraint. Check for duplicate names first.
create unique index if not exists players_name_unique_idx on public.players (name);

alter table public.players enable row level security;

drop policy if exists "Anyone can view players" on public.players;
drop policy if exists "Public can read players" on public.players;
drop policy if exists "Admin can insert players" on public.players;
drop policy if exists "Admin can update players" on public.players;
drop policy if exists "Admin can delete players" on public.players;

create policy "Public can read players"
on public.players for select to anon, authenticated
using (true);

create policy "Admin can insert players"
on public.players for insert to authenticated
with check ((auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');

create policy "Admin can update players"
on public.players for update to authenticated
using ((auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com')
with check ((auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');

create policy "Admin can delete players"
on public.players for delete to authenticated
using ((auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');
