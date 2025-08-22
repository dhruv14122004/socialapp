-- Add likes table for favorites functionality
create table if not exists likes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  post_id uuid references posts(id) on delete cascade,
  created_at timestamp with time zone not null default now(),
  unique(user_id, post_id)
);

-- Enable RLS
alter table likes enable row level security;

-- Create policies
create policy "Users can read all likes" on likes for select using (true);
create policy "Users can like posts" on likes for insert with check (auth.uid() = user_id);
create policy "Users can unlike posts" on likes for delete using (auth.uid() = user_id);
