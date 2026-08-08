-- Enable RLS on all tables
alter table users enable row level security;
alter table customers enable row level security;
alter table providers enable row level security;
alter table vendors enable row level security;
alter table delivery_partners enable row level security;
alter table services enable row level security;
alter table orders enable row level security;
alter table payments enable row level security;
alter table commissions enable row level security;
alter table ratings enable row level security;
alter table notifications enable row level security;
alter table delivery_assignments enable row level security;
alter table chat_rooms enable row level security;
alter table messages enable row level security;
alter table support_tickets enable row level security;
alter table promotions enable row level security;
alter table zones enable row level security;
alter table admin_settings enable row level security;
alter table audit_logs enable row level security;

-- Create RLS policies for users
create policy "Users can view their own profile"
  on users for select
  using (auth.uid() = auth_id or auth.jwt() ->> 'role' = 'admin');

create policy "Users can update their own profile"
  on users for update
  using (auth.uid() = auth_id);

-- Create RLS policies for customers
create policy "Customers can view own data"
  on customers for select
  using (auth.uid() in (select auth_id from users where id = user_id));

-- Create RLS policies for notifications
create policy "Users can view own notifications"
  on notifications for select
  using (auth.uid() in (select auth_id from users where id = user_id));

create policy "Users can update own notifications"
  on notifications for update
  using (auth.uid() in (select auth_id from users where id = user_id));

-- Create RLS policies for orders
create policy "Users can view related orders"
  on orders for select
  using (
    auth.uid() in (
      select auth_id from users where id in (select user_id from customers where id = customer_id)
      union
      select auth_id from users where id in (select user_id from providers where id = provider_id)
    )
    or auth.jwt() ->> 'role' = 'admin'
  );
