-- Netflix project
drop table netflix;
create table netflix(
show_id varchar(6),
type varchar(10),
title varchar(150),
director varchar(200),
casts varchar(1000),
country varchar(100),
date_added varchar(50),
release_year int,
rating varchar(10),
duration varchar(15),
listed_in varchar(100),
description varchar(250)
)
alter table netflix alter column country type varchar(1000);

select * from netflix;


--1.Count the number of Movies vs TV Shows

select type,count(*) as total_content from netflix group by type;

-- 2. Find the most common rating for movies and TV shows

select type,rating from
(select type,rating,count(*) as rating_count,
Rank() over(partition by type order by count(*) desc) as Rank
from netflix group by type,rating) as t1
where Rank = 1;


-- 3. List all movies released in a specific year (e.g., 2020)

select * from netflix where type = 'Movie' and release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix

select unnest(string_to_array(country,',')) as new_country,count(show_id) as freq
from netflix group by new_country order by freq desc limit 5;

-- 5. Identify the longest movie

select * from netflix where type = 'Movie' and duration = (select max(duration) from netflix);
 
-- 6. Find content added in the last 5 years

select * from netflix where
to_date(date_added,'Month dd,yyyy') >= current_date - interval '5 years';

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select * from netflix where director = 'Rajiv Chilaka';

-- 8. List all TV shows with more than 5 seasons

select * from netflix where type = 'TV Show' and split_part(duration,' ',1)::int > 5 ;

-- 9. Count the number of content items in each genre

select unnest(string_to_array(listed_in,',')) as genre,count(show_id) as total_count
from netflix group by genre order by total_count desc;

-- 10.Find each year and the average numbers of content release in India on netflix. 

select extract(year from to_date(date_added,'Month dd,YYYY')) as year,
count(*) as yearly_content,
round(count(*)::numeric / (select count(*) from netflix where country = 'India')::numeric*100,2)
as avg_content_per_year from netflix where country = 'India' group by year;

-- 11. List all movies that are documentaries

select * from (
select *,unnest(string_to_array(listed_in,','))  as new_listed_in from netflix where type = 'Movie' 
) as t
where new_listed_in = 'Documentaries';

select * from netflix where type = 'Movie' and listed_in = 'Documentaries';

-- 12. Find all content without a director

select * from netflix where director is null;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 20 years!

select * from netflix where casts ilike '%Salman Khan%' and release_year > extract(year from current_date) - 20;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

select unnest(string_to_array(casts,','))  as actor,count(*) as no_of_movies from netflix
where country ilike '%India%' group by actor order by no_of_movies desc limit 10;

-- 15.
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

select *,
case 
when description ilike '%kill%' or description ilike '%violence%' then 'Bad Content'
else 'Good Content'
end category
from netflix;

with cte as (
select *,
case
when description ilike '%kill%' or description ilike '%violence%' then 'Bad Content'
else 'Good Content'
end category
from netflix
)
select category,count(*) as total_count from cte group by category;
