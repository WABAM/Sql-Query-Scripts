---DYNAMIC SQL TO CREATE PIVOT TABLE

DECLARE 
    @columns NVARCHAR(MAX) = '',
	@sql     NVARCHAR(MAX) = '';

SELECT 
    @columns += QUOTENAME(cohort_index) + ','
FROM 
    (select distinct cohort_index from #cohort_retention) m
ORDER BY 
    cohort_index;

SET @columns = LEFT(@columns, LEN(@columns) - 1);

PRINT @columns;


-- construct dynamic SQL
SET @sql ='
---# Return number of unique elements in the object
SELECT * 
FROM   
(
	  select distinct
		Cohort_Date,
		cohort_index,
		CustomerID 
	  from #cohort_retention
) t 
PIVOT(
    COUNT(CustomerID) 
    FOR cohort_index IN ('+ @columns +')
) AS pivot_table
order by Cohort_Date
';

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;
Footer
© 2022 GitHub, Inc.
Footer navigation
Terms
Privacy