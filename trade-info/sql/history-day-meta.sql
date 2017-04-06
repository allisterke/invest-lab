DROP TABLE IF EXISTS invest.history_day;
CREATE TABLE invest.history_day
(
    date DATE,
    code CHAR(6),
    name CHAR(20),
    close DOUBLE,
    high  DOUBLE,
    low   DOUBLE,
    open  DOUBLE,
    yesterday_close DOUBLE,
    diff  DOUBLE,
    diff_rate DOUBLE,
    turnover_rate DOUBLE,
    volume BIGINT,
    turnover DOUBLE,
    total_market_value DOUBLE,
    circulation_market_value DOUBLE,
    deals INT,
    PRIMARY KEY (date, code),
    INDEX date_index (date),
    INDEX code_index (code),
    INDEX name_index (name)
) ENGINE = innodb, CHARSET utf8;
