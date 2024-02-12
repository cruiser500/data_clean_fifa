

--1. check the height and weight columns and change data types
--change height to decimal | change weight to decimal
select
	Height -- varchar
	, height_converted --decimal
	, Weight --varchar
	, weight_converted --decimal
from
	fifa21_raw_data

	-- casting height into decimal
select
	cast(REPLACE(REPLACE(Height, '''', '.'), '"', '') AS decimal(10, 2)) as height_converted
from
	fifa21_raw_data

	--adding new column
alter table fifa21_raw_data
	add height_converted decimal(10,3);

	--update the height column datatype
update fifa21_raw_data
	set height_converted = cast(REPLACE(REPLACE(Height, '''', '.'), '"', '') AS decimal(10, 3))


	-- casting the weight column
select
	cast(REPLACE(weight, 'lbs', '') AS decimal(10, 2)) as weight_converted
from
	fifa21_raw_data

	--adding new column
alter table fifa21_raw_data
	add weight_converted decimal(10,3);

	--update the height column datatype
update fifa21_raw_data
	set weight_converted = cast(REPLACE(weight, 'lbs', '') AS decimal(10, 2))



--2. seperate the joined column into year, month, and day
	--update joined into date format
select
	cast(joined as date) as joined_date
from
	fifa21_raw_data

	--seperate columns created
select
	day(cast(joined as date)) as day_of_month
	, month(cast(joined as date)) as month_number
	, year(cast(joined as date)) as year_number
from 
	fifa21_raw_data f

	--day column added to table
alter table fifa21_raw_data
	add joined_day_date int;

	--day column added to new column
update fifa21_raw_data
	set joined_day_date = day(cast(joined as date))

	--month column added to table
alter table fifa21_raw_data
	add joined_month_date int;

	--month column added to new column
update fifa21_raw_data
	set joined_month_date = month(cast(joined as date))

	--year column added to table
alter table fifa21_raw_data
	add joined_year_date int;

	--year column added to new column
update fifa21_raw_data
	set joined_year_date = year(cast(joined as date))

	--all columns select statement
select
	joined_day_date
	, joined_month_date
	, joined_year_date
from
	fifa21_raw_data


--3. clean and transform the value, wage, and release clauses columns into columns of integers (currently varchar)
select
	value
	, wage
	, [Release Clause]
from
	fifa21_raw_data

-- replace (€) and M from value
select
	try_cast(REPLACE(REPLACE(value, '€', ''), 'M', '') AS decimal(10, 2)) as value_converted
from
	fifa21_raw_data

--value column added to table
alter table fifa21_raw_data
	add value_converted decimal(10,2);

	--value column added to new column
update fifa21_raw_data
	set value_converted = try_cast(REPLACE(REPLACE(value, '€', ''), 'M', '') AS decimal(10, 2))


--replace (€) and K from wage
select
	try_cast(REPLACE(REPLACE(wage, '€', ''), 'K', '') AS decimal(10, 2)) as wage_converted
from
	fifa21_raw_data

	--value column added to table
alter table fifa21_raw_data
	add wage_converted decimal(10,2);

	--value column added to new column
update fifa21_raw_data
	set wage_converted = try_cast(REPLACE(REPLACE(wage, '€', ''), 'K', '') AS decimal(10, 2)) 

-- replace (€) and M from release clause
select
	try_cast(REPLACE(REPLACE([Release Clause], '€', ''), 'M', '') AS decimal(10, 2)) as release_clause_converted
from
	fifa21_raw_data

--value column added to table
alter table fifa21_raw_data
	add release_clause_converted decimal(10,2);

	--value column added to new column
update fifa21_raw_data
	set release_clause_converted = try_cast(REPLACE(REPLACE([Release Clause], '€', ''), 'M', '') AS decimal(10, 2))

select
	value_converted
	, wage_converted
	, release_clause_converted
from
	fifa21_raw_data


