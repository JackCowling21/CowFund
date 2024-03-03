DELIMITER $$

CREATE PROCEDURE CountMatchingDays(
    IN Ticker1 VARCHAR(255),
    IN Ticker2 VARCHAR(255)
)
BEGIN
    SELECT
        S1.Direction,
        COUNT(*) AS DaysCount
    FROM (
        SELECT
            date,
            CASE WHEN close > open THEN 'Up'
                 WHEN close < open THEN 'Down'
                 ELSE 'Unchanged'
            END AS Direction
        FROM DailyStockPrices
        WHERE Symbol = Ticker1
    ) AS S1
    JOIN (
        SELECT
            date,
            CASE WHEN close > open THEN 'Up'
                 WHEN close < open THEN 'Down'
                 ELSE 'Unchanged'
            END AS Direction
        FROM DailyStockPrices
        WHERE Symbol = Ticker2
    ) AS S2 ON S1.date = S2.date AND S1.Direction = S2.Direction
    WHERE S1.Direction <> 'Unchanged'
    GROUP BY S1.Direction;
END$$

DELIMITER ;