-- Create support_tickets table
create table if not exists support_tickets (
  id uuid primary key default gen_random_uuid(),
  ticket_number varchar(50) not null unique,
  user_id uuid not null references users(id) on delete cascade,
  subject varchar(255) not null,
  description text,
  status varchar(50) default 'open' check (status in ('open', 'in_progress', 'resolved', 'closed')),
  priority varchar(50) default 'medium' check (priority in ('low', 'medium', 'high', 'urgent')),
  assigned_to uuid references users(id),
  resolution text,
  created_at timestamp default now(),
  updated_at timestamp default now(),
  resolved_at timestamp
);

create index if not exists idx_support_tickets_user_id on support_tickets(user_id);
create index if not exists idx_support_tickets_status on support_tickets(status);
