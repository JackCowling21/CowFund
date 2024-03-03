WITH Stock1Movement AS (
    SELECT 
        date,
        CASE WHEN close > open THEN 'Up'
             WHEN close < open THEN 'Down'
             ELSE 'Unchanged'
        END AS Direction
    FROM DailyStockPrices
    WHERE ticker = 'TICKER1'
),
Stock2Movement AS (
    SELECT 
        date,
        CASE WHEN close > open THEN 'Up'
             WHEN close < open THEN 'Down'
             ELSE 'Unchanged'
        END AS Direction
    FROM DailyStockPrices
    WHERE ticker = 'TICKER2'
)
SELECT 
    Stock1Movement.Direction,
    COUNT(*) AS DaysCount
FROM Stock1Movement
JOIN Stock2Movement ON Stock1Movement.date = Stock2Movement.date
    AND Stock1Movement.Direction = Stock2Movement.Direction
WHERE Stock1Movement.Direction <> 'Unchanged'
GROUP BY Stock1Movement.Direction;
