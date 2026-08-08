-- Create chat_rooms table
create table if not exists chat_rooms (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  participant_ids uuid[] not null,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

-- Create messages table
create table if not exists messages (
  id uuid primary key default gen_random_uuid(),
  chat_room_id uuid not null references chat_rooms(id) on delete cascade,
  sender_id uuid not null references users(id) on delete cascade,
  message_text text,
  image_url text,
  is_read boolean default false,
  read_at timestamp,
  created_at timestamp default now()
);

create index if not exists idx_messages_chat_room_id on messages(chat_room_id);
create index if not exists idx_messages_sender_id on messages(sender_id);
