-- Create notifications table
create table if not exists notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  title varchar(255) not null,
  body text,
  type varchar(50) not null,
  related_id uuid,
  is_read boolean default false,
  read_at timestamp,
  data jsonb,
  created_at timestamp default now()
);

create index if not exists idx_notifications_user_id on notifications(user_id);
create index if not exists idx_notifications_is_read on notifications(is_read);
