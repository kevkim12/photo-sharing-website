CREATE DATABASE IF NOT EXISTS photoshare;
USE photoshare;
DROP TABLE IF EXISTS Pictures CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

CREATE TABLE Users (
    user_id int4  AUTO_INCREMENT NOT NULL,
    firstname varchar(100) NOT NULL,
    lastname varchar(100) NOT NULL,
    password varchar(255) NOT NULL,
    gender varchar(6),
    email varchar(255) UNIQUE NOT NULL,
    hometown varchar(255),
    birthday DATE NOT NULL,
    score INTEGER,
  CONSTRAINT users_pk PRIMARY KEY (user_id),
  CHECK (firstname IS NOT NULL AND
         lastname IS NOT NULL AND
         password IS NOT NULL AND
         email IS NOT NULL AND
         birthday IS NOT NULL)
);

CREATE TABLE Friends (
  user_id1 int4,
  user_id2 int4,
  FOREIGN KEY (user_id1) REFERENCES Users(user_id),
  FOREIGN KEY (user_id2) REFERENCES Users(user_id)
);

CREATE TABLE Pictures
(
  picture_id int4 AUTO_INCREMENT NOT NULL UNIQUE,
  user_id int4,
  imgdata longblob ,
  caption VARCHAR(255),
  INDEX upid_idx (user_id),
  CONSTRAINT pictures_pk PRIMARY KEY (picture_id)
);



CREATE TABLE Albums
(
  album_id int4 AUTO_INCREMENT NOT NULL UNIQUE,
  date DATE,
  albumname varchar(255),
  user_id int4,
  CONSTRAINT albums_pk PRIMARY KEY (album_id)
);

CREATE TABLE Contains
(
  album_id int4,
  picture_id int4,
  CONSTRAINT contains_pk PRIMARY KEY (picture_id),
  FOREIGN KEY (album_id) REFERENCES Albums(album_id),
  FOREIGN KEY (picture_id) REFERENCES Pictures(picture_id)
);

CREATE TABLE Comments
(
  comment_id int4 AUTO_INCREMENT NOT NULL UNIQUE,
  date DATE,
  text varchar(500),
  CONSTRAINT comment_pk PRIMARY KEY (comment_id)
);

CREATE TABLE Tag
(
  word varchar(255) NOT NULL UNIQUE,
  PRIMARY KEY (word)
);

CREATE TABLE Associate
(
  picture_id int4,
  word varchar(255),
  CONSTRAINT associate_pk PRIMARY KEY (picture_id, word),
  FOREIGN KEY (picture_id) REFERENCES Pictures(picture_id),
  FOREIGN KEY (word) REFERENCES Tag(word)
);

CREATE TABLE Has
(
  comment_id int4,
  picture_id int4,
  CONSTRAINT comment_pk PRIMARY KEY (comment_id, picture_id),
  FOREIGN KEY (comment_id) REFERENCES Comments(comment_id),
  FOREIGN KEY (picture_id) REFERENCES Pictures(picture_id)
);

CREATE TABLE Likes
(
  user_id int4,
  picture_id int4,
  CONSTRAINT like_pk PRIMARY KEY (user_id, picture_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (picture_id) REFERENCES Pictures(picture_id)
);

CREATE TABLE Made
(
  user_id int4,
  comment_id int4,
  CONSTRAINT made_pk PRIMARY KEY (user_id, comment_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (comment_id) REFERENCES Comments(comment_id)
)