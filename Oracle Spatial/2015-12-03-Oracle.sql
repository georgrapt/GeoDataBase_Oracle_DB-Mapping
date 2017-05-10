-- Exercise 2015-12-03

-- Exercice in class - WKT

drop table t1;

create TABLE t1 (
 ID NUMBER PRIMARY KEY,
 name VARCHAR(20),
 geometry SDO_GEOMETRY
 );

 
INSERT INTO t1 VALUES (1, 'Point', SDO_GEOMETRY('POINT(10 10)'));

INSERT INTO t1 VALUES (2, 'Multipoint', SDO_GEOMETRY('MULTIPOINT((10 10), (20 20), (30 30))'));
 
INSERT INTO t1 VALUES (3, 'Linestring', SDO_GEOMETRY('LINESTRING (10 10, 20 20, 30 40)')); 

INSERT INTO t1 VALUES (4, 'Multilinestring',
  sdo_geometry (2006, null, null, sdo_elem_info_array (1,4,2, 1,2,1, 5,2,1), 
  sdo_ordinate_array (50,105, 55,105, 60,110, 50,110))
);

INSERT INTO t1 VALUES (5, 'Polygon', SDO_GEOMETRY('POLYGON ((
33.0 54.0,  35.0 54.0, 35.0 55.0, 33.0 55.0, 33.0 54.0))'));

INSERT INTO t1 VALUES (6, 'Multipolygon', SDO_GEOMETRY('MULTIPOLYGON (
 ((2 4, 4 3, 10 3, 13 5, 13 9, 11 13, 5 13, 2 11, 2 4)),
 ((7 5, 7 10, 10 10, 10 5, 7 5)))'));

INSERT INTO t1 VALUES (7, 'Collection', SDO_GEOMETRY(' 
 GEOMETRYCOLLECTION (POINT (10.0 100.0), 
 LINESTRING (15.0 100.0, 25.0 100.0), 
 POLYGON ((10.0 125.0, 20.0 125.0, 20.0 130.0, 10.0 130.0, 10.0 125.0)), 
 POLYGON ((10.0 105.0, 15.0 105.0, 20.0 110.0, 10.0 110.0, 10.0 105.0)))')
);

INSERT INTO t1 VALUES(10, 'polygon_with_hole',
  SDO_GEOMETRY(2003, NULL, NULL,
    SDO_ELEM_INFO_ARRAY(1,1003,1, 19,2003,1), -- polygon with hole
    SDO_ORDINATE_ARRAY(2,4, 4,3, 10,3, 13,5, 13,9, 11,13, 5,13, 2,11, 2,4,
        7,5, 7,10, 10,10, 10,5, 7,5)
  )
);

SELECT * FROM t1;

SELECT SDO_UTIL.TO_WKTGEOMETRY(geometry) FROM t1 WHERE ID=10;


INSERT INTO USER_SDO_GEOM_METADATA
VALUES ('T1','geometry', MDSYS.SDO_DIM_ARRAY(
	MDSYS.SDO_DIM_ELEMENT ('X', -10, 200, 0.05),
	MDSYS.SDO_DIM_ELEMENT ('Y', -10, 200, 0.05)
	),
	NULL
);

SELECT * FROM user_sdo_geom_metadata;

SELECT id, name, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT (geometry, 0.05) FROM t1;


COMMIT;
-----------------------------------------------------------------------------------------
-- Exercise 2015-12-03

-- Exercice in class - exercise sheet

DROP TABLE t2;

CREATE TABLE t2 (
  idt2 NUMBER PRIMARY KEY,
  description VARCHAR2(50),
  geom SDO_GEOMETRY
);
-- a)
INSERT INTO t2 (idt2,description,geom)
VALUES (
  1,
  'a - Arc string',
  sdo_geometry (2002, null, null, sdo_elem_info_array (1,2,2), 
    sdo_ordinate_array (10,65, 15,70, 20,65, 25,60, 30,65))
);

-- b)
INSERT INTO t2 (idt2,description,geom)
VALUES (
  2,
  'b - Multiarc - touching',
  sdo_geometry (2006, null, null, sdo_elem_info_array (1,2,2, 7,2,2), 
    sdo_ordinate_array (50,65, 50,70, 55,68, 55,68, 60,65, 60,70))
);

-- c)
INSERT INTO t2 (idt2,description,geom)
VALUES (
  3,
  'c - Circle',
  sdo_geometry (2003, null, null, sdo_elem_info_array (1,1003,4), 
    sdo_ordinate_array (15,145, 10,150, 20,150))
);


-- d)
INSERT INTO t2 (idt2,description,geom)
VALUES (
  4,
  'd - Polygon',
  sdo_geometry (2003, null, null, sdo_elem_info_array (1,1003,1), 
    sdo_ordinate_array (10,175, 10,165, 20,165, 15,170, 25,170, 20,165, 
      30,165, 30,175, 10,175))
);

-- e)
INSERT INTO t2 (idt2,description,geom)
VALUES (
  5,
  'e - Polygon with island polygon',
  sdo_geometry (2007, null, null, 
    sdo_elem_info_array (1,1003,3, 5,2003,1, 25,1003,3), 
    sdo_ordinate_array (60,168, 65,160,  
      61,167, 64,167, 64,161, 61,161, 61,162, 62,163, 61,164, 61,165, 61,166, 61,167, 
      62,166, 63,162))
);

-- f)
INSERT INTO t2 (idt2,description,geom)
VALUES (
  6,
  'f - Multipolygon - disjoint',
  sdo_geometry (2007, null, null, sdo_elem_info_array (1,1003,1, 11,1003,3), 
    sdo_ordinate_array (50,105, 55,105, 60,110, 50,110, 50,105, 62,108, 65,112))
);

-- g)
INSERT INTO t2 (idt2,description,geom)
VALUES (
  7,
  'g - Multipolygon - tangent * INVALID 13350',
  sdo_geometry (2007, null, null, sdo_elem_info_array (1,1003,3, 5,1003,3), 
    sdo_ordinate_array (50,125, 55,130, 55,128, 60,132))
);

-- h)
INSERT INTO t2 (idt2,description,geom)
VALUES (
  8,
  'h - Heterogeneous collection',
  sdo_geometry (2004, null, null, sdo_elem_info_array (1,1,1, 3,2,1, 7,1003,3, 11,1003,1), 
    sdo_ordinate_array (10,100, 15,100, 25,100, 10,125, 20,130, 10,105, 15,105, 20,110, 10,110,
      10,105))
);



INSERT INTO USER_SDO_GEOM_METADATA
VALUES ('T2','geom', MDSYS.SDO_DIM_ARRAY(
	MDSYS.SDO_DIM_ELEMENT ('X', -10, 200, 0.05),
	MDSYS.SDO_DIM_ELEMENT ('Y', -10, 200, 0.05)
	),
	NULL
);

SELECT * FROM user_sdo_geom_metadata;

-- Validation
SELECT idt2, description, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT (geom, 0.05) FROM t2;


COMMIT;

