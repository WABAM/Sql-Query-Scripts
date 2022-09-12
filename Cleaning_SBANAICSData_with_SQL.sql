use [portfolioproject];

select*
into sba_naics_sectorCodes
from(
  SELECT 

      [NAICS Industry Description],
		iif([NAICS Industry Description] like '%Sector%',substring([NAICS Industry Description], 8, 2 ),'') as LookupCodes,
		iif([NAICS Industry Description]like '%–%',Ltrim(substring([NAICS Industry Description], CHARINDEX('–',[NAICS Industry Description]) + 1, LEN([NAICS Industry Description]) )), '') Sector
	  FROM [dbo].['table_of_size_standards-all$']
	  where [NAICS Industry Description] is not NULL
	  and [NAICS Codes] is  NULL
 )main
	  where LookupCodes != '' 


/****** Script for SelectTopNRows command from SSMS  ******/

insert into [dbo].[sba_naics_sector_codes]
values 
  ('Sector 31 – 33 – Manufacturing', 32, 'Manufacturing'), 
  ('Sector 31 – 33 – Manufacturing', 33, 'Manufacturing'), 
  ('Sector 44 - 45 – Retail Trade', 45, 'Retail Trade'),
  ('Sector 48 - 49 – Transportation and Warehousing', 49, 'Transportation and Warehousing')

update  [dbo].[sba_naics_sectorCodes]
set Sector = 'Manufacturing'
where LookupCodes = 31

  SELECT [NAICS Industry Description]
      ,[LookupCodes]
      ,[Sector]
  FROM [dbo].[sba_naics_sectorCodes]
   where LookupCodes != 'bu' 
  order by LookupCodes
