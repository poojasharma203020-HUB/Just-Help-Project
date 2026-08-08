-- Create delivery_partners table
create table if not exists delivery_partners (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references users(id) on delete cascade,
  vehicle_type varchar(50) not null check (vehicle_type in ('bike', 'car', 'van', 'truck')),
  vehicle_number varchar(50),
  license_number varchar(50),
  insurance_expiry date,
  rating decimal(3, 2) default 0,
  total_deliveries int default 0,
  total_earnings decimal(12, 2) default 0,
  is_available boolean default true,
  current_latitude decimal(10, 8),
  current_longitude decimal(11, 8),
  bank_account varchar(50),
  bank_name varchar(100),
  verification_status varchar(50) default 'pending',
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_delivery_partners_user_id on delivery_partners(user_id);
create index if not exists idx_delivery_partners_is_available on delivery_partners(is_available);
