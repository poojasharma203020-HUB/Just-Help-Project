-- Create services table
create table if not exists services (
  id uuid primary key default gen_random_uuid(),
  provider_id uuid not null references providers(id) on delete cascade,
  service_name varchar(255) not null,
  description text,
  category varchar(100) not null,
  base_price decimal(10, 2) not null,
  currency varchar(3) default 'USD',
  duration_minutes int,
  rating decimal(3, 2) default 0,
  total_bookings int default 0,
  is_active boolean default true,
  image_url text,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_services_provider_id on services(provider_id);
create index if not exists idx_services_category on services(category);
create index if not exists idx_services_is_active on services(is_active);
