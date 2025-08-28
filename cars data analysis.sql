--identifying all the brand names available
SELECT DISTINCT make
FROM `mu-first-project-467008.cars.car_info` 

--identifying the most expensive brands
SELECT DISTINCT make,AVG(price) AS average_price
FROM `mu-first-project-467008.cars.car_info` 
GROUP BY make
ORDER BY average_price DESC
--to determine the car brand that produces the largest cars INTERMS OF HEIGHT
SELECT DISTINCT make,AVG(height) AS average_height
FROM `mu-first-project-467008.cars.car_info` 
GROUP BY make
ORDER BY average_height DESC
--it appears that peugot produces the largest vehicles at 57.18
--determining the car brand that makes the largest horsepower
SELECT DISTINCT make,AVG(horsepower) AS average_horsepower
FROM `mu-first-project-467008.cars.car_info` 
GROUP BY make
ORDER BY average_horsepower DESC
--this shows that porsche is produces cars with the highest horsepower
--determining the cars that have the largest engine siza and its loaction
SELECT DISTINCT make,AVG(engine_size) AS average_engine_size, engine_location
FROM `mu-first-project-467008.cars.car_info` 
GROUP BY make, engine_location
ORDER BY average_engine_size DESC
--determining the cars that have the largest rear engine
SELECT DISTINCT make,AVG(engine_size) AS average_engine_size, engine_location
FROM `mu-first-project-467008.cars.car_info` 
WHERE engine_location = "rear"
GROUP BY make, engine_location
ORDER BY average_engine_size DESC
-- determining the most efficient cars interms of value brand
WITH brand_stats AS (
  SELECT
    make,
    AVG(highway_mpg) AS avg_mpg,
    AVG(price) AS avg_price
  FROM `mu-first-project-467008.cars.car_info`
  GROUP BY make
),
overall_stats AS (
  SELECT
    AVG(highway_mpg) AS overall_avg_mpg,
    AVG(price) AS overall_avg_price
  FROM `mu-first-project-467008.cars.car_info`
)
SELECT
  bs.make,
  bs.avg_mpg,
  bs.avg_price,
  (bs.avg_mpg - os.overall_avg_mpg) AS mpg_above_avg,
  (os.overall_avg_price - bs.avg_price) AS price_below_avg,
  -- A simple value score (higher is better)
  (bs.avg_mpg / os.overall_avg_mpg) / (bs.avg_price / os.overall_avg_price) AS value_score
FROM brand_stats bs
CROSS JOIN overall_stats os
WHERE bs.avg_mpg > os.overall_avg_mpg
  AND bs.avg_price < os.overall_avg_price
ORDER BY value_score DESC;

--determining the most efficient car 
SELECT make,AVG(highway_mpg) AS average_highway_mpg, AVG(price) AS average_price, AVG(highway_mpg)/AVG(price) AS ratio_of_efficiency
FROM `mu-first-project-467008.cars.car_info` 
WHERE rank = 1
GROUP BY make
ORDER BY ratio_of_efficiency DESC
--this indicate that isuzu is the most efficient cars


