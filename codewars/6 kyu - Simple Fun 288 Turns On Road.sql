--# write your SQL statement here: 
-- you are given a table 'turns_on_road' with columns 'x' and 'y'
-- all types are BigInt
-- return a table with these columns and your result in a column named 'res'.

create or replace function min_turns(x bigint, y bigint) 
returns bigint
language plpgsql
as
$$
declare
  z bigint;
  x0 bigint;
  y0 bigint;
  tmp bigint;
begin

if (x = 0 and y = 0) or (x = 1 and y = 0) then
  return 0;
end if;

z := 4 * (case when abs(x) < abs(y) then abs(y) - 1 else abs(x) - 1 end);

tmp := z / 4;

x0 := -tmp;
y0 := -tmp;

tmp := (z + 1) / 2 + 1;

if y = y0 and x >= x0 and x <= x0 + tmp then 
  return z;
end if;

x0 := x0 + tmp;

if x = x0 and y >= y0 and y <= y0 + tmp then 
  return z + 1;
end if;

y0 := y0 + tmp;

tmp := -tmp - 1;

if y = y0 and x <= x0 and x >= x0 + tmp then 
  return z + 2;
end if;

x0 := x0 + tmp;

if x = x0 and y <= y0 and y >= y0 + tmp then
  return z + 3;
end if;

return z + 4;

end;
$$;

select  x,
        y,
        min_turns(x, y) as res
from turns_on_road;