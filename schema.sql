-- Gama Research — DCF Workstation. Run this once in the Supabase SQL editor.
-- One row per state key; the whole workstation state lives in a JSONB column,
-- which is the right shape for a single-user tool (no migrations when the
-- frontend adds fields).

create table if not exists public.workstation_state (
  key         text primary key,
  data        jsonb not null default '{}'::jsonb,
  updated_at  timestamptz not null default now()
);

-- Lock the table down. The server uses the service-role key, which bypasses
-- RLS; with RLS enabled and no policies, the public anon key can do nothing.
alter table public.workstation_state enable row level security;
