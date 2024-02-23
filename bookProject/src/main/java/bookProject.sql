----계정 생성(system 계정으로 연결)
--create user book identified by 1234;
--grant connect, resource to book;
----system계정 끊고나서 book계정 생성

--삭제(기존데이터 삭제)
drop table BOARD cascade constraints;
drop table ORDERS cascade constraints;
drop table BOOK cascade constraints;
drop table USERS cascade constraints;

--테이블 생성(book 계정으로 연결)
CREATE TABLE "BOOK" (
	"BOOK_ID"	NUMBER(10)		NOT NULL,
	"BOOK_NAME"	NVARCHAR2(50)		NOT NULL,
	"BOOK_PRICE"	NUMBER(10)		NOT NULL,
	"BOOK_AUTHOR"	NVARCHAR2(20)		NOT NULL,
	"BOOK_PUBLISHER"	NVARCHAR2(20)		NOT NULL,
	"BOOK_CATEGORY"	NVARCHAR2(20)		NOT NULL,
	"BOOK_STOCK"	NUMBER(5)	DEFAULT 0	NOT NULL
);

CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER(10)		NOT NULL,
	"BOARD_TITLE"	NVARCHAR2(100)		NOT NULL,
	"BOARD_CONTENT"	NVARCHAR2(1000)		NOT NULL,
	"BOARD_DATE"	DATE	DEFAULT SYSDATE NOT NULL,
	"BOARD_HIT"	NUMBER(10)	DEFAULT 0	NOT NULL,
	"BOARD_IMG"	VARCHAR2(50)		NULL,
	"BOOK_ID"	NUMBER(10)		NOT NULL
);

CREATE TABLE "USERS" (
	"USER_ID"	VARCHAR2(20)		NOT NULL,
	"USER_PW"	VARCHAR2(20)		NOT NULL,
	"USER_NAME"	NVARCHAR2(10)		NOT NULL,
	"USER_EMAIL"	VARCHAR2(30)		NOT NULL,
	"USER_TEL"	VARCHAR2(20)		NOT NULL,
	"USER_ADDRESS"	NVARCHAR2(50)		NOT NULL,
	"USER_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"USER_MANAGER"	NUMBER(1)	DEFAULT 0	NOT NULL
);

CREATE TABLE "ORDERS" (
	"ORDER_NO"	NUMBER(10)		NOT NULL,
	"ORDER_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"ORDER_NUM"	NUMBER(10)		NOT NULL,
	"BOOK_ID"	NUMBER(10)		NOT NULL,
	"USER_ID"	VARCHAR2(20)		NOT NULL
);

ALTER TABLE "BOOK" ADD CONSTRAINT "PK_BOOK" PRIMARY KEY (
	"BOOK_ID"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "USERS" ADD CONSTRAINT "PK_USERS" PRIMARY KEY (
	"USER_ID"
);

ALTER TABLE "ORDERS" ADD CONSTRAINT "PK_ORDERS" PRIMARY KEY (
	"ORDER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_BOOK_TO_BOARD_1" FOREIGN KEY (
	"BOOK_ID"
)
REFERENCES "BOOK" (
	"BOOK_ID"
);

ALTER TABLE "ORDERS" ADD CONSTRAINT "FK_BOOK_TO_ORDERS_1" FOREIGN KEY (
	"BOOK_ID"
)
REFERENCES "BOOK" (
	"BOOK_ID"
);

ALTER TABLE "ORDERS" ADD CONSTRAINT "FK_USERS_TO_ORDERS_1" FOREIGN KEY (
	"USER_ID"
)
REFERENCES "USERS" (
	"USER_ID"
);


----시퀀스
----BOARD
--create sequence SEQ_BOARD_NO
--	increment by 1  -- 1씩 증가
--	start with 1	--시작값 1
--	minvalue 1		--최소값 1
--	nomaxvalue		--최대값은 무한대
--	nocycle			--순환하지 않음 (최대값에 도달하면 다시 초기값부터 할당)
--	nocache;		--캐시 안함 (cache로 설정하면 메모리에서 미리 할당)
----ORDERS
--create sequence SEQ_ORDER_NO
--	increment by 1  -- 1씩 증가
--	start with 10000001	--시작값 10000001
--	nomaxvalue		--최대값은 무한대
--	nocycle			--순환하지 않음 (최대값에 도달하면 다시 초기값부터 할당)
--	nocache;		--캐시 안함 (cache로 설정하면 메모리에서 미리 할당)	
----BOOK
--create sequence SEQ_BOOK_ID
--   increment by 1
--   start with 10001
--   nomaxvalue
--   nocycle
--   nocache;

--더미데이터
--유저
INSERT INTO USERS (USER_ID, USER_PW, USER_NAME, USER_EMAIL, USER_TEL, USER_ADDRESS, USER_DATE, USER_MANAGER)
 VALUES ('manager', 1234, 'manager', 'manager@naver.com', '010-1234-5678', '경기도 수원시', sysdate, 1);
INSERT INTO USERS (USER_ID, USER_PW, USER_NAME, USER_EMAIL, USER_TEL, USER_ADDRESS, USER_DATE, USER_MANAGER)
 VALUES ('user1', 1234, 'user1', 'user1@naver.com', '010-1234-5678', '경기도 수원시', sysdate, 0);

 
-- BOOK 테이블 더미데이터 삽입
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9001, '이기적 유전자', 15000, '작가 1', '출판사 1', '과학', 100);

INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9002, '코스모스', 20000, '작가 2', '출판사 2', '과학', 50);

INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9003, '이처럼 사소한 것들', 18000, '작가 3', '출판사 3', '소설', 80);

INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9004, '메리골드 마음 사진관', 22000, '작가 4', '출판사 4', '소설', 120);

INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9005, '토익 기출문제집4 RC', 25000, '작가 5', '출판사 5', '언어', 70);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9006, '토익 기출문제집4 LC', 15000, '작가 1', '출판사 1', '언어', 100);

INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9007, '최소한의 한국사', 20000, '작가 2', '출판사 2', '역사', 50);

INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9008, '최소한의 세계사', 18000, '작가 3', '출판사 3', '역사', 80);

INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9009, '앞서가는 사람의 생존전략', 22000, '작가 4', '출판사 4', '자기계발', 120);

INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9010, '세이노의 가르침', 25000, '작가 5', '출판사 5', '자기계발', 70);


-- BOARD 테이블 더미데이터 삽입
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '이기적 유전자', '이 책은 이기적인 유전자들에 관한 이야기를 다룹니다. 흥미로운 내용들이 많이 있어요!', SYSDATE, 0, 'images/과학1.jpg', '9001');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '코스모스', '코스모스는 우주에 관한 멋진 책입니다. 우주의 비밀을 여는 여행에 동참하세요!', SYSDATE, 0, 'images/과학2.jpg', '9002');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '이처럼 사소한 것들', '작가가 이 책에서는 일상의 사소한 것들에 대해 얘기합니다. 읽으면 마음이 따뜻해집니다!', SYSDATE, 0, 'images/소설1.jpg', '9003');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '메리골드 마음 사진관', '메리골드 마음 사진관은 마음 따뜻해지는 이야기들이 가득합니다. 여러분의 마음도 따뜻해질 거예요!', SYSDATE, 0, 'images/소설2.jpg', '9004');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '토익 기출문제집4 RC', '토익 기출문제집4 RC는 토익 시험을 대비하는 데 꼭 필요한 책입니다. 스터디 파트너와 함께 공부해요!', SYSDATE, 0, 'images/언어1.jpg', '9005');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '토익 기출문제집4 LC', '토익 기출문제집4 LC는 토익 시험을 대비하는 데 꼭 필요한 책입니다. 스터디 파트너와 함께 공부해요!', SYSDATE, 0, 'images/언어2.jpg', '9006');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '최소한의 한국사', '최소한의 한국사는 중요한 한국사 지식을 요약해서 담고 있습니다. 공부에 도움이 많이 될 거예요!', SYSDATE, 0, 'images/역사1.jpg', '9007');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '최소한의 세계사', '최소한의 세계사는 중요한 세계사 지식을 요약해서 담고 있습니다. 공부에 도움이 많이 될 거예요!', SYSDATE, 0, 'images/역사2.jpg', '9008');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '앞서가는 사람의 생존전략', '앞서가는 사람의 생존전략은 여러분이 성공하기 위한 지침서입니다. 지금 바로 읽어보세요!', SYSDATE, 0, 'images/자기계발1.jpg', '9009');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '세이노의 가르침', '세이노의 가르침은 여러분의 삶에 도움이 될 지혜로운 이야기들이 가득합니다. 지혜를 찾고 싶은 분들에게 추천합니다!', SYSDATE, 0, 'images/자기계발2.jpg', '9010');

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '이기적 유전자', '이 책은 이기적인 유전자들에 관한 이야기를 다룹니다. 흥미로운 내용들이 많이 있어요!', SYSDATE, 0, 'images/과학1.jpg', '9001');

--추가 더미데이터
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9011, '파브르 식물기', 27500, '작가 6', '출판사 3', '과학', 50);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9012, '뉴럴 링크', 32000, '작가 7', '출판사 8', '과학', 100);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9013, '모순', 21500, '작가 4', '출판사 6', '소설', 30);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9014, '맡겨진 소녀', 18900, '작가 6', '출판사 1', '소설', 25);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9015, '일본어 상용한자 1026', 19000, '작가 7', '출판사 7', '언어', 70);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9016, '굿모닝 독학 일본어 첫걸음', 21000, '작가 9', '출판사 9', '언어', 65);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9017, '부의 세계사', 13000, '작가 8', '출판사 4', '역사', 80);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9018, '이주하는 인류', 27000, '작가 9', '출판사 6', '역사', 90);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9019, '퓨처셀프', 33000, '작가 6', '출판사 8', '자기계발', 110);
 
INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, BOOK_AUTHOR, BOOK_PUBLISHER, BOOK_CATEGORY, BOOK_STOCK)
 VALUES (9020, '사람들이 죽기 전에 후회하는 33가지', 31000, '작가 9', '출판사 9', '자기계발', 30);

INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '파브르 식물기', '이 책은 식물학자 파브르가 작성한 식물 도감입니다!', SYSDATE, 0, 'images/과학3.jpg', '9011');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '뉴럴 링크', '구글, 테슬라, 메타, 아마존, 마이크로소프트가 주목하는 스마트폰 이후 최대의 기술 혁명!', SYSDATE, 0, 'images/과학4.jpg', '9012');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '모순', '이 책은 작가 양귀자가 1998년 펴낸 세 번째 장편소설!', SYSDATE, 0, 'images/소설3.jpg', '9013');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '맡겨진 소녀', '애정 없는 부모로부터 낯선 친척 집에 맡겨진 한 소녀의 이야기!', SYSDATE, 0, 'images/소설4.jpg', '9014');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '일본어 상용한자 1026', '이 책은 일본어 상용한자 교육의 교과서!', SYSDATE, 0, 'images/언어3.jpg', '9015');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '굿모닝 독학 일본어 첫걸음', '매일 아침 공부하는 일본어를 통해 더욱 좋은 교육!', SYSDATE, 0, 'images/언어4.jpg', '9016');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '부의 세계사', '세계 부의 흐름을 한눈에 살펴보는 아주 흥미로운 여정!', SYSDATE, 0, 'images/역사3.jpg', '9017');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '이주하는 인류', '우리는 모두 이주민의 후예다!', SYSDATE, 0, 'images/역사4.jpg', '9018');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '퓨처셀프', '현재의 나를 올바른 방향으로 이끌고 싶다면 반드시 봐야 할 책!', SYSDATE, 0, 'images/자기계발3.jpg', '9019');
 
INSERT INTO BOARD (BOARD_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_DATE, BOARD_HIT, BOARD_IMG, BOOK_ID)
VALUES (SEQ_BOARD_NO.nextval, '사람들이 죽기 전에 후회하는 33가지', '얼마나 일찍 죽음이라는 존재를 느끼는지가 성공과 실패를 나눈다!', SYSDATE, 0, 'images/자기계발4.jpg', '9020');

