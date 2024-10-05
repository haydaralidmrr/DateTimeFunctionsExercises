--elimizde musterilerin oldugu veri tabanindan dogum gunu bugun olanlari cekin
SELECT * FROM LAB01
WHERE DATEPART(MONTH,BIRTHDATE) = DATEPART(MONTH,GETDATE()) AND
DATEPART(DAY,BIRTHDATE) = DATEPART(DAY,GETDATE())

-- dogum gunu 1 hafta sonra olanlari listeleyiniz.

SELECT * FROM LAB01
WHERE DATEPART(MONTH,BIRTHDATE) = DATEPART(MONTH,DATEADD(WEEK,1,GETDATE())) AND
DATEPART(DAY,BIRTHDATE) = DATEPART(DAY,DATEADD(WEEK,1,GETDATE()))

--dogum yili telefon numarasinda gecen musterileri listeleyiniz.

SELECT ID,NAME_,SURNAME,BIRTHDATE,TELNR1 
FROM LAB03
WHERE TELNR1 LIKE '%'+DATENAME(YEAR,BIRTHDATE)+'%'

--elimizde bir market alisveris verisi var. Burada okutulan her urunun okutulma tarihi var.ayrica her islem icin
--baslama ve bitis tarihi var.
--buna gore kasada kesilen her fatura icin musterinin kasada kac saniye bekledigini listeleyiniz.

SELECT DISTINCT INVOICENO, DATE_ START_DATE, INVOICEDATE FINISH_DATE,
DATEDIFF(SECOND,DATE_,INVOICEDATE) WAITING_TIME
FROM LAB04
ORDER BY 1

-- Her bir musterinin kasada ortalama bekleme suresini her bir sehir icin listeleyiniz.
SELECT CITY,
AVG(DATEDIFF(SECOND,DATE_,INVOICEDATE)) AVG_WAITING_TIME
FROM LAB05
GROUP BY CITY
ORDER BY 1

--Kasada kasiyerlerin performansini olcmek istiyoruz. Bu verilere gore bir kasiyerin bir urunu ortalama kac saniyede
--okuttugunu sehirlere gore listeleyiniz.

SELECT CITY, SUM(DURATION)TOTAL_DURATION, 
SUM(TOTAL_AMOUNT)TOTAL_PRODUCT_AMOUNT,
ROUND(SUM(DURATION) / SUM(TOTAL_AMOUNT),2) SPENDING_TIME_FOR_ONE_PRODUCT
FROM
(
SELECT CITY,INVOICENO,MIN(BARCODEDATE)FIRST_BARCODE, MAX(BARCODEDATE) LAST_BARCODE,
DATEDIFF(SECOND,MIN(BARCODEDATE),MAX(BARCODEDATE))DURATION, SUM(AMOUNT)TOTAL_AMOUNT, COUNT(ITEMCODE)ITEM_COUNT
FROM LAB06
GROUP BY CITY,INVOICENO
)T
GROUP BY CITY
ORDER BY SPENDING_TIME_FOR_ONE_PRODUCT


-- hangi saat ne kadar yorum atildigi bilgisini listeleyiniz

select DATEPART(HOUR,CreationDate)'HOURS', COUNT(Id)COMMENT_NUMBERS from LAB08
GROUP BY DATEPART(HOUR,CreationDate)
ORDER BY 1