
SELECT *FROM twitterdb.tweets


-- Top screen_name by tweets
SELECT count(*) as total, screen_name
FROM twitterdb.tweets
group by screen_name
order by 1 DESC;

-- Top place_name by tweets
SELECT count(*) as total, place_name
FROM twitterdb.tweets
group by place_name
order by 1 DESC;


-- Top place_type by tweets
SELECT count(*) as total, place_type
FROM twitterdb.tweets
group by place_type
order by 1 DESC;

-- Top mention1 by tweets
SELECT count(*) as total, mention1
FROM twitterdb.tweets
group by mention1
order by 1 DESC;

-- Top mention2 by tweets
SELECT count(*) as total, mention2
FROM twitterdb.tweets
group by mention2
order by 1 DESC;

-- Top hashtag1 by tweets
SELECT count(*) as total, hashtag1
FROM twitterdb.tweets
group by hashtag1
order by 1 DESC;

-- Top hashtag1 by tweets
SELECT count(*) as total, hashtag2
FROM twitterdb.tweets
group by hashtag2
order by 1 DESC;

select * from tweets;

