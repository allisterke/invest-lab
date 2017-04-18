SELECT * FROM invest.history_day d,
  (SELECT max(date) date FROM invest.history_day et) end_date,
  (SELECT DISTINCT date FROM invest.history_day st ORDER BY date DESC LIMIT 4, 1) start_date
WHERE d.date BETWEEN start_date.date AND end_date.date
  AND d.close > d.yesterday_close AND d.low <= d.yesterday_close * 0.96
  AND d.low <= 1.1 * (SELECT min(t.low) FROM invest.history_day t
    WHERE t.code = d.code AND t.date BETWEEN d.date - INTERVAL 90 DAY AND d.date)
#       AND d.turnover > 1.2 * (SELECT avg(turnover) FROM invest.history_day WHERE code = d.code
#                                 AND date BETWEEN (SELECT date FROM invest.history_day WHERE date < d.date ORDER BY date DESC LIMIT 4, 1) AND d.date - INTERVAL 1 DAY)
      AND d.turnover > 1.2 * (SELECT avg(turnover) FROM invest.history_day WHERE code = d.code
                                AND date BETWEEN d.date - INTERVAL 10 DAY AND d.date - INTERVAL 1 DAY);
