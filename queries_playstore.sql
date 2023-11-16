-- Comments in SQL Start with dash-dash --

--1: Find the app with an ID of 1880 --
SELECT * FROM analytics WHERE id = 1880;

--2: Find the ID and app name for all apps that were last updated on August 01, 2018. -- 
SELECT id, app_name FROM analytics WHERE last_updated = '2018-08-01';

--3: Count the number of apps in each category, e.g. “Family | 1972”. --
SELECT category, count(*) FROM analytics GROUP BY category;

--4: Find the top 5 most-reviewed apps and the number of reviews for each. --
SELECT * FROM analytics ORDER BY reviews desc LIMIT 5;

--5: Find the app that has the most reviews with a rating greater than equal to 4.8. --
SELECT * FROM analytics WHERE rating >= 4.8 ORDER BY reviews desc LIMIT 1;
--6: Find the average rating for each category ordered by the highest rated to lowest rated. --
SELECT category, AVG(rating) FROM analytics GROUP BY category ORDER BY AVG(rating) desc;

--7: Find the name, price, and rating of the most expensive app with a rating that’s less than 3. --
SELECT app_name, price, rating FROM analytics WHERE rating < 3 ORDER BY price desc LIMIT 1;

--8: Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first. --
SELECT * FROM analytics WHERE min_installs < 50 AND NOT rating IS NULL ORDER BY rating desc;

--9: Find the names of all apps that are rated less than 3 with at least 10000 reviews. --
SELECT app_name FROM analytics WHERE rating < 3 AND reviews >= 1E4;

--10: Find the top 10 most-reviewed apps that cost between 10 cents and a dollar --
SELECT * FROM analytics WHERE price BETWEEN .10 AND 1.00 ORDER BY reviews DESC LIMIT 10;

--11: Find the most out of date app. -- 
SELECT * FROM analytics ORDER BY last_updated LIMIT 1;

--12: Find the most expensive app --
SELECT * FROM analytics ORDER BY price DESC LIMIT 1;

--13: Count all the reviews in the Google Play Store. --
SELECT COUNT(reviews) AS total_reviews FROM analytics;

--14: Find all the categories that have more than 300 apps in them. --
SELECT category, COUNT(app_name) AS total_apps FROM analytics GROUP BY category HAVING COUNT(app_name) > 300;

--15: Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display the name of the app along with the number of reviews, the min_installs, and the proportion. --
SELECT app_name, reviews, min_installs, min_installs/reviews AS installs_per_review FROM analytics ORDER BY installs_per_review DESC LIMIT 1;

--FS1: Find the name and rating of the top rated apps in each category, among apps that have been installed at least 50,000 times. --
SELECT app_name, rating, category
    FROM analytics
  WHERE (rating, category) in (SELECT MAX(rating), category FROM analytics WHERE min_installs > 5E4 GROUP BY category) ORDER BY category;

--FS2: Find all the apps that have a name similar to “facebook”. --
SELECT * FROM analytics WHERE app_name ILIKE '%facebook%';

--FS3: Find all the apps that have more than 1 genre. --
SELECT * FROM analytics WHERE  array_length(genres, 1) > 1;

--FS4: Find all the apps that have education as one of their genres. --
SELECT * FROM analytics WHERE genres @> '{"Education"}';