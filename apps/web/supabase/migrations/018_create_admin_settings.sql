-- Create admin_settings table
create table if not exists admin_settings (
  id uuid primary key default gen_random_uuid(),
  setting_key varchar(255) not null unique,
  setting_value text,
  data_type varchar(50),
  description text,
  updated_by uuid references users(id),
  created_at timestamp default now(),
  updated_at timestamp default now()
);

-- Create audit_logs table
create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references users(id),
  action varchar(255) not null,
  entity_type varchar(100),
  entity_id uuid,
  changes jsonb,
  ip_address inet,
  user_agent text,
  created_at timestamp default now()
);

create index if not exists idx_audit_logs_user_id on audit_logs(user_id);
create index if not exists idx_audit_logs_created_at on audit_logs(created_at);
