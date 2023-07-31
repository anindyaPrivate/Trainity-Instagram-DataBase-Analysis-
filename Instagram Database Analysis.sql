use instagram

select * from users

/* Identify the five oldest users on Instagram from the provided database.*/
select username,created_at from users
order by created_at 
limit 5

/*Identify users who have never posted a single photo on Instagram*/
SELECT u.id AS user_id, u.username, u.created_at
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
WHERE p.id IS NULL;

/* Determine the winner of the contest and provide their details to the team */

select * from photos,likes,users;

SELECT u.id AS user_id, u.username, count(l.user_id) AS total_likes
FROM users u
JOIN photos p ON u.id = p.user_id
LEFT JOIN likes l ON p.id = l.photo_id
GROUP BY u.id, u.username
ORDER BY total_likes DESC
LIMIT 1;

 /* Identify and suggest the top five most commonly used hashtags on the platform.*/
select * from photo_tags,tags
select t.tag_name , count(p.photo_id) as hash_tag from photo_tags p 
inner join  tags t on t.id = p.tag_id
group by t.tag_name
order by hash_tag  desc;

/* Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.*/
select * from users
SELECT 
    DAYNAME(created_at) AS registration_day,
    COUNT(*) AS registration_count
FROM 
   users
GROUP BY 
    registration_day
ORDER BY 
    registration_count DESC
LIMIT 1;

/*Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users*/
select * from users,photos
with base as(
select u.id as userid,count(p.id)as photoid 
from users u 
left join photos p on p.id = u.id	
group by u.id)
select sum(photoid)as total_photos,
count(userid) as total_users,
 sum(photoid)/count(userid)as photos_div_users 
from base
/*Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users*/
select * from users,photos
SELECT 
    COUNT(p.id) / COUNT(DISTINCT u.id) AS avg_posts_per_user,
    COUNT(p.id) AS total_photos,
    COUNT(DISTINCT u.id) AS total_users,
    COUNT(p.id) / COUNT(DISTINCT u.id) AS photos_per_user
FROM 
    users u
LEFT JOIN 
    photos p ON u.id = p.user_id;
    
/* Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user*/
select * from users,likes 
SELECT 
    user_id, username
FROM 
    users u
INNER JOIN
    (SELECT COUNT(DISTINCT photo_id) AS total_photos FROM likes) l
LEFT JOIN
    (SELECT user_id, COUNT(DISTINCT photo_id) AS liked_photos
     FROM likes
     GROUP BY user_id) ul
ON u.id = ul.user_id
WHERE
    ul.liked_photos = l.total_photos;
    
