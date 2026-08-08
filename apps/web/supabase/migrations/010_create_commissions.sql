-- Create commissions table
create table if not exists commissions (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  provider_id uuid not null references providers(id) on delete cascade,
  commission_rate decimal(5, 2) not null,
  commission_amount decimal(10, 2) not null,
  status varchar(50) default 'pending' check (status in ('pending', 'approved', 'paid', 'rejected')),
  payout_date timestamp,
  notes text,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_commissions_order_id on commissions(order_id);
create index if not exists idx_commissions_provider_id on commissions(provider_id);
create index if not exists idx_commissions_status on commissions(status);
