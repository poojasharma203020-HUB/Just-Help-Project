-- Create ratings table
create table if not exists ratings (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  rater_id uuid not null references users(id) on delete cascade,
  ratee_id uuid not null references users(id) on delete cascade,
  rating int not null check (rating >= 1 and rating <= 5),
  review text,
  professionalism int check (professionalism >= 1 and professionalism <= 5),
  punctuality int check (punctuality >= 1 and punctuality <= 5),
  communication int check (communication >= 1 and communication <= 5),
  quality int check (quality >= 1 and quality <= 5),
  is_anonymous boolean default false,
  created_at timestamp default now(),
  updated_at timestamp default now()
);

create index if not exists idx_ratings_order_id on ratings(order_id);
create index if not exists idx_ratings_ratee_id on ratings(ratee_id);
create index if not exists idx_ratings_rater_id on ratings(rater_id);
