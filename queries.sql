-- ==========================================
-- 1. TOP SELLING TRACKS
-- ==========================================
SELECT t.TrackId,
    t.Name AS TrackName,
    SUM(il.Quantity) AS TotalQuantity,
    SUM(il.UnitPrice * il.Quantity) AS Total_Revenue
FROM InvoiceLine il
    JOIN Track t ON il.TrackId = t.TrackId
GROUP BY t.TrackId,
    t.Name
ORDER BY Total_Revenue DESC
LIMIT 10;
-- ==========================================
-- 2. REVENUE PER REGION (Country)
-- ==========================================
SELECT c.Country,
    SUM(i.Total) AS Total_Revenue
FROM Invoice i
    JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY c.Country
ORDER BY Total_Revenue DESC;
-- ==========================================
-- 3. MONTHLY PERFORMANCE
-- ==========================================
SELECT strftime('%Y-%m', InvoiceDate) AS Month,
    SUM(Total) AS Monthly_Revenue
FROM Invoice
GROUP BY Month
ORDER BY Month;