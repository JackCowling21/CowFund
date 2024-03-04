import mysql.connector
from mysql.connector import Error

# Database connection parameters
host = 'localhost'
database = 'your_database_name'
user = 'your_username'
password = 'your_password'

try:
    # Establish connection to MySQL database
    connection = mysql.connector.connect(host=host, database=database, user=user, password=password)

    if connection.is_connected():
        cursor = connection.cursor()

        # Step 1: Retrieve all ticker pairs
        cursor.execute("SELECT id, ticker1, ticker2 FROM TickerPair")
        ticker_pairs = cursor.fetchall()

        # Step 2: Cycle through pairs and execute the SQL statement for each
        for pair_id, ticker1, ticker2 in ticker_pairs:
            sql_query = f"""
WITH Stock1Movement AS (
    SELECT 
        date,
        CASE WHEN close > open THEN 'Up'
             WHEN close < open THEN 'Down'
             ELSE 'Unchanged'
        END AS Direction
    FROM DailyStockPrices
    WHERE ticker = '{ticker1}'
),
Stock2Movement AS (
    SELECT 
        date,
        CASE WHEN close > open THEN 'Up'
             WHEN close < open THEN 'Down'
             ELSE 'Unchanged'
        END AS Direction
    FROM DailyStockPrices
    WHERE ticker = '{ticker2}'
)
SELECT 
    Stock1Movement.Direction,
    COUNT(*) AS DaysCount
FROM Stock1Movement
JOIN Stock2Movement ON Stock1Movement.date = Stock2Movement.date
    AND Stock1Movement.Direction = Stock2Movement.Direction
WHERE Stock1Movement.Direction <> 'Unchanged'
GROUP BY Stock1Movement.Direction;
"""
            cursor.execute(sql_query)
            results = cursor.fetchall()

            # Assuming 'DaysUp' and 'DaysDown' are the columns to update
            days_up = days_down = 0
            for direction, days_count in results:
                if direction == 'Up':
                    days_up = days_count
                elif direction == 'Down':
                    days_down = days_count

            # Step 3: Update the TickerPair table with the results
            update_query = f"""
UPDATE TickerPair
SET DaysUp = {days_up}, DaysDown = {days_down}
WHERE id = {pair_id}
"""
            cursor.execute(update_query)
            connection.commit()

        print("TickerPair table updated successfully")

except Error as e:
    print(f"Error while connecting to MySQL: {e}")

finally:
    # Close database connection
    if connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")
