-- Create zones table
create table if not exists zones (
  id uuid primary key default gen_random_uuid(),
  zone_name varchar(255) not null unique,
  description text,
  city varchar(100),
  polygon_coordinates jsonb,
  base_delivery_charge decimal(10, 2),
  is_active boolean default true,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_zones_city on zones(city);
create index if not exists idx_zones_is_active on zones(is_active);
