

select *
from [NashvilleHousing].[dbo].[housingproject2]

--standardize date format

select saledateconverted2 , convert(Date,saledate)
from [NashvilleHousing].[dbo].[housingproject2]

update [NashvilleHousing].[dbo].[housingproject2]
set saledate=convert(Date,saledate)

alter table [NashvilleHousing].[dbo].[housingproject2]
add saledateconverted2 date;

update [NashvilleHousing].[dbo].[housingproject2]
set saledateconverted2=convert(Date,saledate)

--populate property address

 select *
 from [NashvilleHousing].[dbo].[housingproject2]
 where propertyaddress is null
 order by ParcelID

 select a.parcelID,a.propertyaddress,b.parcelID,b.propertyaddress,isnull(a.propertyaddress,b.PropertyAddress)
 from [NashvilleHousing].[dbo].[housingproject2] a
 join [NashvilleHousing].[dbo].[housingproject2] b
 on a.parcelid=b.parcelid
 and a.uniqueid<>b.uniqueid
 where a.propertyaddress is null


update a
set propertyaddress=isnull(a.propertyaddress,b.PropertyAddress)
from [NashvilleHousing].[dbo].[housingproject2] a
 join [NashvilleHousing].[dbo].[housingproject2] b
 on a.parcelid=b.parcelid
 and a.uniqueid<>b.uniqueid
 where a.propertyaddress is null

 -- breakout address in individual column 

 select propertyaddress
 from [NashvilleHousing].[dbo].[housingproject2]

 select 
 substring(propertyaddress, 1 , charindex (',',propertyaddress)-1) as address,
 substring(propertyaddress, charindex (',',propertyaddress) + 1 , len (propertyaddress))as address

 from [NashvilleHousing].[dbo].[housingproject2]
 

 alter table [NashvilleHousing].[dbo].[housingproject2]
add  Propertysplitaddress2 nvarchar(255);

update [NashvilleHousing].[dbo].[housingproject2]
set Propertysplitaddress2= substring(propertyaddress, 1 , charindex (',',propertyaddress)-1)

alter table [NashvilleHousing].[dbo].[housingproject2]
add Propertysplitcity  nvarchar(255);

update [NashvilleHousing].[dbo].[housingproject2]
set Propertysplitcity  =substring(propertyaddress, charindex (',',propertyaddress) + 1 , len (propertyaddress))

select*
from [NashvilleHousing].[dbo].[housingproject2]

select 
parsename(replace(owneraddress,',','.'),3)as address,
parsename(replace(owneraddress,',','.'),2)as city,
parsename(replace(owneraddress,',','.'),1)as state


from [NashvilleHousing].[dbo].[housingproject2]

-- Adding the necessary columns


 alter table [NashvilleHousing].[dbo].[housingproject2]
add  Ownersplitaddres nvarchar(255);

update [NashvilleHousing].[dbo].[housingproject2]
set Ownersplitaddres= parsename(replace(owneraddress,',','.'),3)

alter table [NashvilleHousing].[dbo].[housingproject2]
add ownersplitcity nvarchar(255);

update [NashvilleHousing].[dbo].[housingproject2]
set ownersplitcity  =parsename(replace(owneraddress,',','.'),2)

alter table [NashvilleHousing].[dbo].[housingproject2]
add ownersplitstate nvarchar(255);

update [NashvilleHousing].[dbo].[housingproject2]
set ownersplitstate   =parsename(replace(owneraddress,',','.'),1)

--Final view

select *
from [NashvilleHousing].[dbo].[housingproject2]

--Change NO to N and YES to Y 

select distinct(soldasvacant), count(soldasvacant)
from [NashvilleHousing].[dbo].[housingproject2]
group by soldasvacant
order by soldasvacant

select soldasvacant
,case	 when soldasvacant ='Y' then 'YES'
		 when soldasvacant ='N' then 'NO'
		 else soldasvacant
		 end
from [NashvilleHousing].[dbo].[housingproject2]

update [NashvilleHousing].[dbo].[housingproject2]
set soldasvacant=case	 when soldasvacant ='Y' then 'YES'
		 when soldasvacant ='N' then 'NO'
		 else soldasvacant
		 end
select *
from [NashvilleHousing].[dbo].[housingproject2]

--remove duplicates--


WITH rownumcte as(
select * ,
ROW_NUMBER() over(
partition by parcelID,
			propertyaddress,
			saleprice,
			saledate,
			legalreference
			order by
			 uniqueID
			 )
			 row_num
from [NashvilleHousing].[dbo].[housingproject2]
--order by ParcelID
)
DELETE
from rownumcte
where row_num>1
--order by propertyaddress

SELECT* 
FROM
[NashvilleHousing].[dbo].[housingproject2]

ALTER TABLE[NashvilleHousing].[dbo].[housingproject2]
DROP COLUMN  PROPERTYADDRESS

SELECT* 
from [NashvilleHousing].[dbo].[housingproject2]





