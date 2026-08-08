-- Create payments table
create table if not exists payments (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  amount decimal(10, 2) not null,
  payment_method varchar(50) not null check (payment_method in ('credit_card', 'debit_card', 'upi', 'wallet', 'bank_transfer')),
  transaction_id varchar(100),
  status varchar(50) default 'pending' check (status in ('pending', 'success', 'failed', 'refunded')),
  payment_gateway varchar(50),
  payer_email varchar(255),
  payment_date timestamp,
  refund_date timestamp,
  notes text,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_payments_order_id on payments(order_id);
create index if not exists idx_payments_status on payments(status);
