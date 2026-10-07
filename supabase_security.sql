-- GARAGE CALENDAR: production security
-- Run AFTER creating employee accounts in Supabase Auth.
-- This replaces the temporary open CRUD policies used during testing.

-- Remove old temporary policies (safe if they do not exist).
drop policy if exists "appointments_select" on public.appointments;
drop policy if exists "appointments_insert" on public.appointments;
drop policy if exists "appointments_update" on public.appointments;
drop policy if exists "appointments_delete" on public.appointments;

-- RLS must stay enabled.
alter table public.appointments enable row level security;

-- Only authenticated Supabase users can read/write appointments.
create policy "appointments_select_authenticated"
on public.appointments
for select
to authenticated
using (true);

create policy "appointments_insert_authenticated"
on public.appointments
for insert
to authenticated
with check (true);

create policy "appointments_update_authenticated"
on public.appointments
for update
to authenticated
using (true)
with check (true);

create policy "appointments_delete_authenticated"
on public.appointments
for delete
to authenticated
using (true);

-- Realtime publication (ignore the statement if the table is already a member).
alter publication supabase_realtime add table public.appointments;

-- IMPORTANT: create employee accounts in Supabase Dashboard -> Authentication -> Users.
-- Do NOT put service_role/secret keys into index.html.
