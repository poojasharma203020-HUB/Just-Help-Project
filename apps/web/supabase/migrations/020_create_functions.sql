-- Create function to update user updated_at timestamp
create or replace function update_user_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger user_updated_at_trigger
  before update on users
  for each row
  execute procedure update_user_updated_at();

-- Create function to update average rating for providers
create or replace function update_provider_rating()
returns trigger as $$
begin
  update providers
  set rating = (
    select avg(rating::decimal)
    from ratings
    where ratee_id in (select id from users where id = new.provider_id)
  )
  where id = new.provider_id;
  return new;
end;
$$ language plpgsql;

create trigger provider_rating_trigger
  after insert on ratings
  for each row
  when (new.ratee_id in (select id from users where user_type = 'provider'))
  execute procedure update_provider_rating();

-- Create function to update order count
create or replace function update_order_count()
returns trigger as $$
begin
  update customers
  set total_orders = (select count(*) from orders where customer_id = new.customer_id)
  where id = new.customer_id;
  return new;
end;
$$ language plpgsql;

create trigger order_count_trigger
  after insert on orders
  for each row
  execute procedure update_order_count();
