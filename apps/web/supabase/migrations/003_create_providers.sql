-- Create providers table
create table if not exists providers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references users(id) on delete cascade,
  business_name varchar(255) not null,
  business_category varchar(100) not null,
  business_description text,
  business_license text,
  verification_status varchar(50) default 'pending' check (verification_status in ('pending', 'verified', 'rejected', 'suspended')),
  rating decimal(3, 2) default 0,
  total_services int default 0,
  total_earnings decimal(12, 2) default 0,
  bank_account varchar(50),
  bank_name varchar(100),
  is_active boolean default true,
  response_time_minutes int,
  completion_rate decimal(3, 2) default 0,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_providers_user_id on providers(user_id);
create index if not exists idx_providers_verification_status on providers(verification_status);
create index if not exists idx_providers_business_category on providers(business_category);
