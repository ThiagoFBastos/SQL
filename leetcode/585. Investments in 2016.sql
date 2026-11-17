with Insurance2015 as (
    select  *,
            lag(tiv_2015) over(order by tiv_2015 nulls last) as prev2015,
            lead(tiv_2015) over(order by tiv_2015 nulls last) as next2015
    from Insurance
), InsuranceLocation as (
    select  *,
            lag(lat) over(order by lat, lon) as prevLat,
            lead(lat) over(order by lat, lon) as nextLat,
            lag(lon) over(order by lat, lon) as prevLon,
            lead(lon) over(order by lat, lon) as nextLon
    from Insurance
), PolicyHolders as (
    select  P.tiv_2016,
            case
                when (Q.lat = Q.prevLat and Q.lon = Q.prevLon) or (Q.lat = Q.nextLat and Q.lon = Q.nextLon) or P.tiv_2015 not in (coalesce(P.prev2015, -1), coalesce(P.next2015, -1)) then False
                else True
            end as accepted
    from Insurance2015 P inner join InsuranceLocation Q on P.pid = Q.pid
)

select round(cast(sum(tiv_2016) as numeric), 2) as tiv_2016
from PolicyHolders
where accepted = True;