-- Create users table
create table if not exists users (
  id uuid primary key default gen_random_uuid(),
  auth_id uuid not null unique references auth.users(id) on delete cascade,
  email varchar(255) not null unique,
  phone varchar(20),
  first_name varchar(100),
  last_name varchar(100),
  avatar_url text,
  user_type varchar(50) not null check (user_type in ('customer', 'provider', 'vendor', 'delivery', 'admin')),
  status varchar(50) default 'active' check (status in ('active', 'inactive', 'suspended', 'deleted')),
  is_verified boolean default false,
  email_verified_at timestamp,
  phone_verified_at timestamp,
  created_at timestamp default now(),
  updated_at timestamp default now(),
  deleted_at timestamp
);

create index if not exists idx_users_email on users(email);
create index if not exists idx_users_user_type on users(user_type);
create index if not exists idx_users_status on users(status);
