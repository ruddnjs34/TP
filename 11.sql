create table Userinfo(
	userID varchar(20),
	userPassword varchar(20),
	userName varchar(20),
	userEmail varchar(50),
	primary key(userID));

create TABLE BBS(
    bbsID INT,
    bbsTitle VARCHAR(50),
    userID VARCHAR(20),
    bbsContent VARCHAR(2048),
    bbsAvailable INT,
    primary key (bbsID));
    
CREATE TABLE reply (
  reply_number int NOT NULL AUTO_INCREMENT,
  board_number int NOT NULL DEFAULT '0',
  replytext varchar(1000) NOT NULL,
  replyer varchar(50) NOT NULL,
  PRIMARY KEY (reply_number),
  CONSTRAINT fk_board FOREIGN KEY (board_number) REFERENCES BBS(bbsID) ON DELETE CASCADE
);

	
    
 drop table userinfo;
 drop table bbs;
 drop table reply;
 
 create TABLE BBS(
    bbsID INT,
    bbsTitle VARCHAR(50),
    userID VARCHAR(20),
    bbsContent VARCHAR(2048),
    bbsDate date,
    bbsAvailable INT,
    primary key (bbsID));
