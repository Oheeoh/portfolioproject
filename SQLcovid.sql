--select *
--from PortfolioProject..CovidData
--order by 3,4

-- Select Data 

Select Location, date, total_cases,new_cases, total_deaths, population
from PortfolioProject..CovidData
where continent is not null
order by 1,2


-- TOTAL CASES Vs TOTAL DEATHS
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidData
where Location like '%state%'
order by 1,2

-- TOTAL CASES Vs POPULATION
Select Location, date, total_cases, Population, (total_cases/population)*100 as PercentagePopulationInfected
from PortfolioProject..CovidData
where Location like '%state%'
order by 1,2

-- Countries with Highest Infection Rate Compared to Population
Select Location, Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentagePopulationInfected
from PortfolioProject..CovidData
where continent is not null
Group by Location, Population
order by PercentagePopulationInfected desc

-- Countries with highest death count per population
select location, Max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidData
where continent is not null
Group by Location
order by TotalDeathCount desc

-- BREAK THINGS DWON BY CONTINENT
select continent, Max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidData
where continent is not null
Group by continent
order by TotalDeathCount desc

-- showing contintents with highest death count per population
select continent, Max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidData
where continent is not null
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS
Select date, sum(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_Deaths, sum(cast(new_deaths as int))/sum(new_Cases)*100 as DeathPercentage
from PortfolioProject..CovidData
where Continent is not null
Group by date
order by 1,2

