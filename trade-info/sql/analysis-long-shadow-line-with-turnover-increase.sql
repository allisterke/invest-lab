# SELECT avg(ir) FROM (
  SELECT
    t.date,
    t.code,
    d.name,
    exp(sum(log(1 + d.diff_rate / 100))) ir
  FROM (
         SELECT d.*
         FROM invest.history_day d
           JOIN (
                  SELECT
                    min(d.date) date,
                    d.code
                  FROM invest.history_day d
                  WHERE d.date BETWEEN
                        (SELECT min(date)
                         FROM (SELECT DISTINCT d.date
                               FROM invest.history_day d
                               WHERE d.date >= '2016-01-01'
                               ORDER BY d.date ASC
                               LIMIT 120) t)
                        AND
                        (SELECT max(date)
                         FROM (SELECT DISTINCT d.date
                               FROM invest.history_day d
                               WHERE d.date >= '2016-01-01'
                               ORDER BY d.date ASC
                               LIMIT 120) t)
                        AND d.low <= d.open * 0.95 AND d.close > d.open
                        AND d.date - INTERVAL 90 DAY > (SELECT min(date) FROM invest.history_day WHERE code = d.code)
                        AND d.low <= 1.1 * (SELECT min(low) FROM invest.history_day
                            WHERE code = d.code AND date BETWEEN d.date - INTERVAL 90 DAY AND d.date)
#                         AND d.turnover > 1.2 * (SELECT avg(turnover) FROM invest.history_day WHERE code = d.code
#                                                   AND date BETWEEN (SELECT date FROM invest.history_day WHERE date < d.date ORDER BY date DESC LIMIT 4, 1) AND d.date - INTERVAL 1 DAY)
                        AND d.turnover > 1.2 * (SELECT avg(turnover) FROM invest.history_day WHERE code = d.code
                                                  AND date BETWEEN d.date - INTERVAL 10 DAY AND d.date - INTERVAL 1 DAY)
                  GROUP BY d.code) t ON d.date = t.date AND d.code = t.code
       ) t, invest.history_day d
  WHERE t.code = d.code AND d.date BETWEEN t.date AND t.date + INTERVAL 90 DAY AND d.close != 0
  GROUP BY t.code
  ORDER BY ir DESC
; #                     ) t;
