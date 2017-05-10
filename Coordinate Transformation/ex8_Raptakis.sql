--Raptakis Giorgos
--Exercise 8

--Task 1
create table WGS_table( idtest number PRIMARY KEY, geom sdo_geometry);

insert into user_sdo_geom_metadata values(
'WGS_table',
'GEOM',
sdo_dim_array( 
sdo_dim_element(’Lon’,-180,180,0.001),
 sdo_dim_element(’Lat’,-90,90,0.001)),4326);

insert into WGS_table values(1, 
sdo_geometry(2001, 3857, 
sdo_point_type(13.34278,52.50904,null),null,null));

create table GK_table(
idtest number PRIMARY KEY,
geom sdo_geometry);

insert into user_sdo_geom_metadata values(
'GK_TABLE',
'GEOM',
sdo_dim_array( 
sdo_dim_element(’Length’,4386596.4101,4613610.5843, 0.05), sdo_dim_element(’Width’,5237914.5325, 6104496.9694, 0.05)),
31468);

insert into GK_table values(1,
sdo_geometry(2001, 82032, 
sdo_point_type(4589981.76,5820715.67,null),
null,null));

select c1.idtest, c2.idtest,
sdo_geom.sdo_distance(
c2.geom, mdsys.sdo_cs.transform(c1.geom,82032) , 0.001) as distance
from WGS_table c1, GK_table c2
where c1.idtest = c2.idtest;

--Task 2 
insert into WGS_table values(2,
sdo_geometry (2003, 3857, null, 
sdo_elem_info_array(1, 1003, 3),
 sdo_ordinate_array(12,52,13,53)));

--Task 3 
select idtest, sdo_geom.sdo_area(geom, 0.0001)
as area from WGS_table where idtest = 2;

--Task 4 
select idtest, sdo_geom.sdo_area(mdsys.sdo_cs.transform(geom,31468), 0.0001)
as area from WGS_table where idtest = 2;

--Task 5
select idtest, sdo_geom.sdo_area(mdsys.sdo_cs.transform(geom,31467), 0.0001)
as area from WGS_table where idtest = 2;


--The different projections have different spatial distortions. 
--Coming from a projection to another and backwards using reference points 
--leads to different distortions and as a result different coordinates of the same point.
