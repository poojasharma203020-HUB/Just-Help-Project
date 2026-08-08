-- Create vendors table
create table if not exists vendors (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references users(id) on delete cascade,
  shop_name varchar(255) not null,
  shop_description text,
  shop_category varchar(100) not null,
  rating decimal(3, 2) default 0,
  total_products int default 0,
  total_sales decimal(12, 2) default 0,
  bank_account varchar(50),
  bank_name varchar(100),
  is_active boolean default true,
  verification_status varchar(50) default 'pending',
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_vendors_user_id on vendors(user_id);
create index if not exists idx_vendors_shop_category on vendors(shop_category);
