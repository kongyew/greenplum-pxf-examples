DROP TABLE IF EXISTS  sampletable1;
create table sampletable1 as select id from generate_Series(1,10000) id;


---CREATE TABLE sampletable1(id int);
-- INSERT INTO sampletable1 VALUES (1);
-- INSERT INTO sampletable1 VALUES (2);
-- INSERT INTO sampletable1 VALUES (3);


DROP TABLE IF EXISTS  sampletable2;
create table sampletable2 as select generate_Series(1,10000) as a,  md5(random()::text) AS b;

-- CREATE TABLE sampletable2 (a int, b text);
-- INSERT INTO sampletable2 VALUES (1, 'Cheese');
-- INSERT INTO sampletable2 VALUES (2, 'Fish');
-- INSERT INTO sampletable2 VALUES (3, 'Chicken');
