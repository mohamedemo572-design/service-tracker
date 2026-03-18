-- Run this in Supabase SQL Editor

create table if not exists users (
  id serial primary key,
  username text not null unique,
  password text not null,
  tenant_id text not null,
  created_at timestamptz default now()
);

create table if not exists projects (
  id serial primary key,
  tenant_id text not null,
  project_code text not null,
  project_name text not null,
  company text,
  actuator text,
  motor text,
  controller text,
  gear_box text,
  receipt_date date,
  wsh2 date,
  exit_date date,
  reception_notes text,
  created_at timestamptz default now(),
  unique(project_code, tenant_id)
);

create table if not exists coordination_tasks (
  id serial primary key,
  tenant_id text not null,
  job_order_no text,
  project_code text not null,
  project_name text,
  task text,
  description text,
  site text,
  car_supply text,
  car_type text,
  month_sheet text,
  year integer,
  created_at timestamptz default now()
);

create table if not exists project_phases (
  id serial primary key,
  tenant_id text not null,
  project_code text not null,
  phase_name text not null,
  phase_name_ar text not null,
  status text not null default 'pending',
  start_date date,
  end_date date,
  notes text,
  sort_order integer default 0,
  created_at timestamptz default now()
);

-- Enable RLS
alter table users enable row level security;
alter table projects enable row level security;
alter table coordination_tasks enable row level security;
alter table project_phases enable row level security;

-- Allow server (service role) full access — RLS bypassed for service_role
-- Create indexes
create index if not exists idx_projects_tenant on projects(tenant_id);
create index if not exists idx_tasks_tenant on coordination_tasks(tenant_id);
create index if not exists idx_phases_code on project_phases(project_code, tenant_id);

-- Insert demo user (change password in production!)
insert into users (username, password, tenant_id) values
  ('admin', 'admin123', 'tenant_demo')
on conflict (username) do nothing;
