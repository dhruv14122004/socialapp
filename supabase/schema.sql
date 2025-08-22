create table if not exists users (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null unique,
  name text not null,
  avatar_url text,
  is_admin boolean not null default false,
  is_online boolean not null default false,
  joined_at timestamp with time zone not null default now(),
  banned boolean not null default false
);

alter table users enable row level security;

create policy "Users can read public profiles" on users for select using (true);
create policy "Users can update own profile" on users for update using (auth.uid() = id);
create policy "Users can insert own profile" on users for insert with check (auth.uid() = id);

create table if not exists posts (
  id uuid primary key default gen_random_uuid(),
  author_id uuid references users(id) on delete cascade,
  author_name text,
  content text not null,
  media_url text,
  is_anonymous boolean not null default false,
  upvotes int not null default 0,
  downvotes int not null default 0,
  category text not null default 'latest',
  created_at timestamp with time zone not null default now()
);

alter table posts enable row level security;
create policy "Anyone can read posts" on posts for select using (true);
create policy "Authenticated can create posts" on posts for insert with check (auth.uid() = author_id);

-- Likes table for favorites functionality
create table if not exists likes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references users(id) on delete cascade,
  post_id uuid references posts(id) on delete cascade,
  created_at timestamp with time zone not null default now(),
  unique(user_id, post_id)
);

alter table likes enable row level security;
create policy "Users can read all likes" on likes for select using (true);
create policy "Users can like posts" on likes for insert with check (auth.uid() = user_id);
create policy "Users can unlike posts" on likes for delete using (auth.uid() = user_id);

create table if not exists comments (
  id uuid primary key default gen_random_uuid(),
  post_id uuid references posts(id) on delete cascade,
  author_id uuid references users(id) on delete cascade,
  author_name text,
  content text not null,
  is_anonymous boolean not null default false,
  created_at timestamp with time zone not null default now()
);

alter table comments enable row level security;
create policy "Anyone can read comments" on comments for select using (true);
create policy "Authenticated can create comments" on comments for insert with check (auth.uid() = author_id);

create table if not exists messages (
  id uuid primary key default gen_random_uuid(),
  from_id uuid references users(id) on delete cascade,
  to_id uuid references users(id) on delete cascade,
  content text,
  media_url text,
  is_read boolean not null default false,
  created_at timestamp with time zone not null default now()
);

alter table messages enable row level security;
create policy "Participants can read" on messages for select using (auth.uid() = from_id or auth.uid() = to_id);
create policy "Sender can insert" on messages for insert with check (auth.uid() = from_id);

create table if not exists reports (
  id uuid primary key default gen_random_uuid(),
  post_id uuid references posts(id) on delete cascade,
  reporter_id uuid references users(id) on delete cascade,
  reason text,
  created_at timestamp with time zone not null default now()
);

alter table reports enable row level security;
create policy "Admins can read reports" on reports for select using (exists (select 1 from users where id = auth.uid() and is_admin));
create policy "Authenticated can create reports" on reports for insert with check (true);

-- Voting function
create or replace function vote_post(p_post_id uuid, p_delta int)
returns void as $$
begin
  if p_delta > 0 then
    update posts set upvotes = upvotes + 1 where id = p_post_id;
  else
    update posts set downvotes = downvotes + 1 where id = p_post_id;
  end if;
end;
$$ language plpgsql security definer;
