-- Create promotions table
create table if not exists promotions (
  id uuid primary key default gen_random_uuid(),
  title varchar(255) not null,
  description text,
  promo_code varchar(50) not null unique,
  discount_percentage decimal(5, 2),
  discount_amount decimal(10, 2),
  max_usage int,
  current_usage int default 0,
  start_date timestamp not null,
  end_date timestamp not null,
  is_active boolean default true,
  applicable_to varchar(50),
  created_by uuid references users(id),
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_promotions_promo_code on promotions(promo_code);
create index if not exists idx_promotions_is_active on promotions(is_active);
