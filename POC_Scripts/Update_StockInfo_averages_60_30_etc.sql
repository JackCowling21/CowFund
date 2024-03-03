UPDATE StockInfo
INNER JOIN (
    SELECT Symbol, ROUND(AVG(Volume)) AS AverageVolume
    FROM DailyStockPrices
    GROUP BY Symbol
) AS AvgVolumes ON StockInfo.Symbol = AvgVolumes.Symbol
SET StockInfo.DailyAverageAll = AvgVolumes.AverageVolume;
