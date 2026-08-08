-- Create orders table
create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  order_number varchar(50) not null unique,
  customer_id uuid not null references customers(id) on delete cascade,
  provider_id uuid references providers(id),
  service_id uuid references services(id),
  status varchar(50) default 'pending' check (status in ('pending', 'confirmed', 'in_progress', 'completed', 'cancelled')),
  scheduled_date timestamp,
  scheduled_time varchar(10),
  completion_time timestamp,
  order_value decimal(10, 2) not null,
  tax decimal(10, 2) default 0,
  discount decimal(10, 2) default 0,
  total decimal(10, 2) not null,
  payment_status varchar(50) default 'pending' check (payment_status in ('pending', 'paid', 'refunded')),
  notes text,
  rating int check (rating >= 1 and rating <= 5),
  review text,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_orders_customer_id on orders(customer_id);
create index if not exists idx_orders_provider_id on orders(provider_id);
create index if not exists idx_orders_status on orders(status);
create index if not exists idx_orders_payment_status on orders(payment_status);
