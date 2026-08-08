-- Create provider_locations table
create table if not exists provider_locations (
  id uuid primary key default gen_random_uuid(),
  provider_id uuid not null references providers(id) on delete cascade,
  address varchar(255) not null,
  city varchar(100) not null,
  state varchar(100),
  postal_code varchar(20),
  latitude decimal(10, 8),
  longitude decimal(11, 8),
  is_primary boolean default false,
  service_radius_km int default 5,
  is_active boolean default true,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_provider_locations_provider_id on provider_locations(provider_id);
create index if not exists idx_provider_locations_city on provider_locations(city);
create index if not exists idx_provider_locations_coordinates on provider_locations(latitude, longitude);
