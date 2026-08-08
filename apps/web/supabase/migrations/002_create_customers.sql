-- Create customers table
create table if not exists customers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references users(id) on delete cascade,
  bio text,
  rating decimal(3, 2) default 0,
  total_orders int default 0,
  total_spent decimal(12, 2) default 0,
  preferred_payment_method varchar(50),
  is_premium boolean default false,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_customers_user_id on customers(user_id);
create index if not exists idx_customers_rating on customers(rating);
