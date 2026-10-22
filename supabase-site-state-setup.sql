-- eFootball Stats Database: shared award archive, monthly snapshots, editable headings and player-photo storage
-- Run once in Supabase Dashboard -> SQL Editor -> New query.
-- Does NOT delete, recreate, or replace public.players or existing player records/policies.

create table if not exists public.site_state (
  state_key text primary key,
  state_value jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.site_state enable row level security;
grant select on public.site_state to anon, authenticated;
grant insert, update, delete on public.site_state to authenticated;

drop policy if exists "Public can read site state" on public.site_state;
create policy "Public can read site state"
  on public.site_state for select
  to anon, authenticated
  using (true);

drop policy if exists "Admin can insert site state" on public.site_state;
create policy "Admin can insert site state"
  on public.site_state for insert
  to authenticated
  with check ((auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');

drop policy if exists "Admin can update site state" on public.site_state;
create policy "Admin can update site state"
  on public.site_state for update
  to authenticated
  using ((auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');

drop policy if exists "Admin can delete site state" on public.site_state;
create policy "Admin can delete site state"
  on public.site_state for delete
  to authenticated
  using ((auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');

-- Publicly viewable profile/card images; only the configured admin can upload, replace, or delete.
insert into storage.buckets (id, name, public)
values ('player-images', 'player-images', true)
on conflict (id) do update set public = true;

drop policy if exists "Public can read ESD player images" on storage.objects;
create policy "Public can read ESD player images"
  on storage.objects for select
  to public
  using (bucket_id = 'player-images');

drop policy if exists "ESD admin can upload player images" on storage.objects;
create policy "ESD admin can upload player images"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'player-images' and (auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');

drop policy if exists "ESD admin can update player images" on storage.objects;
create policy "ESD admin can update player images"
  on storage.objects for update
  to authenticated
  using (bucket_id = 'player-images' and (auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com')
  with check (bucket_id = 'player-images' and (auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');

drop policy if exists "ESD admin can delete player images" on storage.objects;
create policy "ESD admin can delete player images"
  on storage.objects for delete
  to authenticated
  using (bucket_id = 'player-images' and (auth.jwt() ->> 'email') = 'jahinsadmanalvee@gmail.com');
