--cleaning Data in SQL Queries

select *
from PortfolioProject..NashvilleHousing

-- Standardize Date Format

select SaleDateConverted, convert(Date,SaleDate)
From PortfolioProject..NashvilleHousing

update NashvilleHousing
set SaleDate = convert(Date,SaleDate)

ALTER TABLE NashvilleHousing
add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = Convert(Date, SaleDate)


--- Populate Property Address data

select *
From PortfolioProject..NashvilleHousing
where PropertyAddress is null

select *
From PortfolioProject..NashvilleHousing
order by ParcelID

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, Isnull(a.propertyaddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = Isnull(a.propertyaddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


--- breaking out address into individual columns (address, City, State)

select PropertyAddress
From PortfolioProject..NashvilleHousing
--order by ParcelID


select
substring(propertyAddress, 1, CHARINDEX (',',PropertyAddress) -1) as Address
, substring(propertyAddress, CHARINDEX (',',PropertyAddress) +1, LEN (PropertyAddress)) as Address
From PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
add PropertySplitAddress Nvarchar (255);

update NashvilleHousing
set PropertySplitAddress = substring(propertyAddress, 1, CHARINDEX (',',PropertyAddress) -1)

ALTER TABLE NashvilleHousing
add  PropertySplitCity Nvarchar (255);

update NashvilleHousing
set PropertySplitCity = substring(propertyAddress, CHARINDEX (',',PropertyAddress) +1, LEN (PropertyAddress))




Select OwnerAddress
From PortfolioProject..NashvilleHousing


select
PARSENAME(replace(OwnerAddress,',','.'), 3)
,PARSENAME(replace(OwnerAddress,',','.'), 2)
,PARSENAME(replace(OwnerAddress,',','.'),1)
From PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
add OnwerSplitAddress Nvarchar (255);

update NashvilleHousing
set OnwerSplitAddress = PARSENAME(replace(OwnerAddress,',','.'), 3)

ALTER TABLE NashvilleHousing
add  OnwerSplitCity Nvarchar (255);

update NashvilleHousing
set OwnerSplitCity = PARSENAME(replace(OwnerAddress,',','.'), 2)

ALTER TABLE NashvilleHousing
add OnwerSplitState Nvarchar (255);

update NashvilleHousing
set OnwerSplitState = PARSENAME(replace(OwnerAddress,',','.'),1)



--- Change Y and N to Yes and No in 'sold as Vacant' field

select Distinct(SoldAsVacant), count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes' 
		when SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		END
From PortfolioProject..NashvilleHousing

update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes' 
		when SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
		END




--Remove Duplicates

With RowNumCTE As (
select * ,
	ROW_NUMBER() Over (
	Partition By ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order by 
					UniqueID
					) row_num

From  PortfolioProject..NashvilleHousing
--order by ParcelID
)
--Delete
select *
From RowNumCTE
where row_num >1





---- Delete unused colums

select *
From  PortfolioProject..NashvilleHousing

Alter table PortfolioProject..NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress


Alter table PortfolioProject..NashvilleHousing
Drop Column SALEdate
