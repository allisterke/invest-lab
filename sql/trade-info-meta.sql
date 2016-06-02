
drop table if exists TradeInfo;

create table TradeInfo (
  date      char(10) not null,
  code      char(6) not null,
  close     double not null,
  top       double not null,
  bottom    double not null,
  open      double not null,
  yclose    double not null,
  diff      double not null,
  diffrate  double not null,
  volume    double not null,
  amount    double not null,
  primary key (date, code)
  ) engine = innodb;

create index TradeInfo_date on TradeInfo (date desc);
create index TradeInfo_code on TradeInfo (code);
