-- Presentation File 

USE SCAM;

-- Simple Query
-- To find all the users who all are from New Mexico

SELECT * FROM USER
WHERE Address = 'New Mexico';

-- Aggregate Query
-- To find the total quantity of each type of transaction (like buy or sell) for every cryptocurrency

SELECT 
    U.Name,
    T.Type,
    C.CryptocurrencyName,
    SUM(T.Quantity) AS TotalQuantity
FROM
    User U
        JOIN
    Transaction T ON U.UserID = T.UserID
        JOIN
    Cryptocurrency C ON T.CryptocurrencyID = C.CryptocurrencyID
GROUP BY U.Name , T.Type , C.CryptocurrencyName;

-- Join
-- To displays the names of exchanges and the cryptocurrency 'EOS' is listed.

SELECT 
    E.ExchangeName, C.CryptocurrencyName
FROM
    Exchange E
        JOIN
    Listed_On L ON E.ExchangeID = L.ExchangeID
        JOIN
    Cryptocurrency C ON L.CryptocurrencyID = C.CryptocurrencyID
WHERE C.CryptocurrencyName = 'EOS';

-- Nested Query
-- To find users who own cryptocurrencies priced higher than the average price of all cryptocurrencies

SELECT 
    Name
FROM
    User
WHERE
    UserID IN (SELECT 
            UserID
        FROM
            Cryptocurrency
        WHERE
            Price > (SELECT 
                    AVG(Price)
                FROM
                    Cryptocurrency));
                    
-- Correlated Query
-- To find users who are older than the average age of users sharing the same gender

SELECT 
    U1.Name, U1.Age
FROM
    User U1
WHERE
    U1.Age > (SELECT 
            AVG(U2.Age)
        FROM
            User U2
        WHERE
            U1.Gender = U2.Gender);

-- >= ALL
-- To finds all users whose age is greater than or equal to the average daily change of all cryptocurrencies

SELECT 
    *
FROM
    User
WHERE
    Age >= ALL (SELECT 
            AVG(DailyChange)
        FROM
            Cryptocurrency);

-- Set Operations
-- To find a combined list of unique cryptocurrency names and exchange names, set operations

(SELECT 
    CryptocurrencyName AS Name
FROM
    Cryptocurrency) UNION (SELECT 
    ExchangeName AS Name
FROM
    Exchange);

-- Subqueries in SELECT
-- To find the count of cryptocurrencies for each user.
SELECT 
    UserID,
    (SELECT 
            COUNT(*)
        FROM
            Cryptocurrency
        WHERE
            UserID = User.UserID) AS CryptoCount
FROM
    User;

-- Subqueries in FROM
-- To find the average price of cryptocurrencies listed on each exchange

SELECT 
    E.ExchangeName, AVG(L.Price) AS AvgPrice
FROM
    Exchange E
        JOIN
    (SELECT 
        L.ExchangeID, C.Price
    FROM
        Listed_On L
    JOIN Cryptocurrency C ON L.CryptocurrencyID = C.CryptocurrencyID) AS L ON E.ExchangeID = L.ExchangeID
GROUP BY E.ExchangeName