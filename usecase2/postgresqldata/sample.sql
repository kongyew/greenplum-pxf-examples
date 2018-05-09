DROP TABLE IF EXISTS  sampletable1;
create table sampletable1 as select id from generate_Series(1,10000) id;


---CREATE TABLE postgres_table1(id int);
-- INSERT INTO postgres_table1 VALUES (1);
-- INSERT INTO postgres_table1 VALUES (2);
-- INSERT INTO postgres_table1 VALUES (3);


DROP TABLE IF EXISTS  sampletable2;
create table sampletable2 as select generate_Series(1,10000) as a,  md5(random()::text) AS b;

-- CREATE TABLE testpxf (a int, b text);
-- INSERT INTO testpxf VALUES (1, 'Cheese');
-- INSERT INTO testpxf VALUES (2, 'Fish');
-- INSERT INTO testpxf VALUES (3, 'Chicken');
