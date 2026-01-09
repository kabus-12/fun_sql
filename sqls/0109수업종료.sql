create table goods(
num number(30) PRIMARY KEY,
name VARCHAR2(50) not null,
category VARCHAR2(50) not null,
price number(10) not null,
barcode number(30) not null,
stock number(10) not null
);
ALTER TABLE goods ADD ( num NUMBER(30) PRIMARY KEY);

INSERT into goods
values(1,'삼겹살','육류',10000,1234567899,2);

ALTER TABLE goods MODIFY writer varchar2(100);

INSERT into goods(num)
values(1);

ALTER TABLE GOODS
ADD CONSTRAINT pk_goods_num PRIMARY KEY (num);

ALTER TABLE goods drop COLUMN num;

DELETE FROM goods;

SELECT
    * FROM goods;

delete from goods
where name = '고등어';