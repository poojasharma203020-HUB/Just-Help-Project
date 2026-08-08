-- Create delivery_assignments table
create table if not exists delivery_assignments (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  delivery_partner_id uuid not null references delivery_partners(id) on delete cascade,
  status varchar(50) default 'assigned' check (status in ('assigned', 'accepted', 'picked_up', 'delivered', 'cancelled')),
  assigned_at timestamp default now(),
  accepted_at timestamp,
  picked_up_at timestamp,
  delivered_at timestamp,
  pickup_latitude decimal(10, 8),
  pickup_longitude decimal(11, 8),
  delivery_latitude decimal(10, 8),
  delivery_longitude decimal(11, 8),
  distance_km decimal(10, 2),
  delivery_time_minutes int,
  rating int check (rating >= 1 and rating <= 5),
  review text,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_delivery_assignments_order_id on delivery_assignments(order_id);
create index if not exists idx_delivery_assignments_delivery_partner_id on delivery_assignments(delivery_partner_id);
create index if not exists idx_delivery_assignments_status on delivery_assignments(status);
