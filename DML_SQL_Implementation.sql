USE SCAM;
 
SELECT 
    u.UserID, Name, CryptocurrencyName, Price
FROM
    User u
        JOIN
    Holds h ON u.UserID = h.UserID
        JOIN
    Cryptocurrency c ON h.CryptocurrencyID = c.CryptocurrencyID
WHERE
    CryptocurrencyName = 'BTC';

-- 
SELECT 
    UserID, COUNT(CryptocurrencyID) AS holdings
FROM
    Holds
GROUP BY UserID
ORDER BY holdings;

-- 
SELECT 
    a.WatchlistID,
    a.AlertID,
    c.CryptocurrencyID,
    c.CryptocurrencyName
FROM
    Alert a
        JOIN
    Tracks t ON a.WatchlistID = t.WatchlistID
        JOIN
    Cryptocurrency c ON t.CryptocurrencyID = c.CryptocurrencyID;

-- Error
SELECT 
    c.CryptocurrencyID, c.CryptocurrencyName, e.ExchangeName
FROM
    Cryptocurrency c
        JOIN
    Listed_On l ON l.CryptocurrencyID = e.CryptocurrencyID
        JOIN
    Exchange e ON l.ExchangeID = e.ExchangeID;

SELECT 
    UserID, COUNT(TransactionID)
FROM
    Transaction
GROUP BY UserID;

SELECT 
    UserID, Date, COUNT(TransactionID)
FROM
    Transaction
GROUP BY UserID , Date;

SELECT 
    UserID, SUM(Price * Quantity) AS TotalPurchased
FROM
    Transaction
WHERE
    Type = 'Buy'
GROUP BY UserID
ORDER BY TotalPurchased;

SELECT 
    UserID, SUM(Price * Quantity) AS TotalSold
FROM
    Transaction
WHERE
    Type = 'Buy'
GROUP BY UserID
ORDER BY TotalSold;

-- No Result
SELECT 
    r.AnalysisID,
    r.RiskScore,
    d.DiversificationScore,
    t.TaxSavingsOpportunities,
    t.TaxBracket
FROM
    RiskAssessment r
        JOIN
    Diversification d ON r.AnalysisID = d.AnalysisID
        JOIN
    Tax t ON r.AnalysisID = t.AnalysisID;

SELECT 
    MAX(PercentReturn) AS HighestReturn
FROM
    ProfitAndLoss;
    
    
    
Select * From Alert;