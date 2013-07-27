# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table book (
  id                        bigint not null,
  isbn                      bigint,
  title                     varchar(255),
  constraint pk_book primary key (id))
;

create table rmember (
  id                        bigint not null,
  email_address             varchar(255),
  facebook_token            varchar(255),
  constraint pk_rmember primary key (id))
;

create table read (
  id                        bigint not null,
  rmember_id                bigint,
  start_date                timestamp,
  finish_date               timestamp,
  rating                    integer,
  review                    varchar(255),
  current_thoughts          varchar(255),
  book_id                   bigint,
  constraint pk_read primary key (id))
;

create sequence book_seq;

create sequence rmember_seq;

create sequence read_seq;

alter table read add constraint fk_read_rmember_1 foreign key (rmember_id) references rmember (id);
create index ix_read_rmember_1 on read (rmember_id);
alter table read add constraint fk_read_book_2 foreign key (book_id) references book (id);
create index ix_read_book_2 on read (book_id);



# --- !Downs

drop table if exists book cascade;

drop table if exists rmember cascade;

drop table if exists read cascade;

drop sequence if exists book_seq;

drop sequence if exists rmember_seq;

drop sequence if exists read_seq;

