
Select CategoryID,CategoryName
From Categories

Select CategoryID,ProductName
From Products

Select CategoryName, ProductName
From Products INNER JOIN Categories 
			  ON Products.CategoryID = Categories.CategoryID

Select c.CategoryID,CategoryName, ProductName
From Products p INNER JOIN Categories c 
			  ON p.CategoryID = c.CategoryID

Select c.CategoryID,CategoryName, ProductName
From Categories c INNER JOIN  Products p 
			  ON  c.CategoryID=p.CategoryID 

Select OrderID,CategoryName, ProductName
From Categories c JOIN  Products p 
			  ON  c.CategoryID=p.CategoryID 
			  JOIN [Order Details] od
			  ON od.ProductID = p.ProductID

--Ürünlerimi tedarik edildikleri firmalar ile listeleyin (FirmaAdi| ÜrünAdi)
Select ProductName, CompanyName
From Products p JOIN Suppliers s
				ON p.SupplierID = s.SupplierID
--Beverages kategorisine ait ürünleri stok miktarları ile listeleyin.
Select c.CategoryID,CategoryName, ProductName
From Categories c JOIN  Products p 
			      ON  c.CategoryID=p.CategoryID 
Where CategoryName = 'Beverages'
--Hangi siparişi hangi çalışanım hangi müsteriye satmıştır. (SiparisID, CalisanAdSoyad, ŞirketAdi)
Select OrderID, FirstName+' '+ LastName AS FullName, CompanyName 
From Orders o JOIN Customers c 
			  ON o.CustomerID = c.CustomerID
			  JOIN Employees e
			  ON e.EmployeeID = o.EmployeeID

--Her bir çalışanımın toplam ne kadar satış yaptığını listeleyiniz. (Fiyat-Adet-Indirim)
Select FirstName, LastName , SUM(od.UnitPrice * od.Quantity *(1-od.Discount)) as kazanc
From Employees e JOIN Orders o
				 ON e.EmployeeID = o.EmployeeID
				 JOIN [Order Details] od
				 ON od.OrderID = o.OrderID
Group By FirstName, LastName
Order By 3 desc

Select FirstName+' '+ LastName FullName , SUM(od.UnitPrice * od.Quantity *(1-od.Discount))
From Employees e JOIN Orders o
				 ON e.EmployeeID = o.EmployeeID
				 JOIN [Order Details] od
				 ON od.OrderID = o.OrderID
Group By FirstName, LastName
Order by FullName

--Janet bu güne kadar hangi ürünleri satmış?
Select distinct  ProductName
From Products p JOIN [Order Details] od
				ON p.ProductID = od.ProductID
				JOIN Orders o 
				ON o.OrderID = od.OrderID
				JOIN Employees e 
				ON o.EmployeeID = e.EmployeeID
Where FirstName = 'Janet'

--Ürün çeşidi olarak incelendiğinde en fazla ürün aldığımız 3 toptancıyı toplam kaç çeşit ürün alındığı bilgisi ile birlikte listeleyiniz
Select top 3 s.CompanyName , COUNT(ProductID) UrunCesidiAdeti
From Products p JOIN Suppliers s
				ON p.SupplierID = s.SupplierID
Group By s.CompanyName
Order by 2 desc
--Şirket adında a geçen müşterilerin vermiş olduğu 
--Nancy, Andrew ve Janet tarafından onaylanmış 
--Speedy Express firması ile taşınmamış siparişlere 
--ne kadar kargo ücreti ödenmiştir?
Select c.CompanyName, SUM(o.Freight) KargoUcreti
From Employees e JOIN Orders o
				 ON e.EmployeeID = o.EmployeeID
				 JOIN Customers c
				 ON c.CustomerID = o.CustomerID
				 JOIN Shippers s
				 ON s.ShipperID = o.ShipVia
Where c.CompanyName LIKE '%a%' AND
	  e.FirstName IN ('Nancy','Andrew','Janet') AND
	  s.CompanyName != 'Speedy Express'  
Group By c.CompanyName
Order By 2 desc

Select CategoryName, ProductName
From Categories RIGHT JOIN Products
				ON Categories.CategoryID = Products.CategoryID

Select CategoryName, ProductName
From Products LEFT JOIN Categories
				ON Categories.CategoryID = Products.CategoryID

Select CategoryName, ProductName
From Products FULL JOIN Categories
				ON Categories.CategoryID = Products.CategoryID




--ODEV
--1996 yýlýnda firmamýzdan urun almýþ müsteriler kimlerdir?
select distinct CompanyName
from Customers c full join Orders o
				 on c.CustomerID =o.CustomerID
where OrderID is not null and YEAR(OrderDate)='1996'
--Stokta olmayan ve tedavülden kalkmış ürünlerin tedarikçilerinin telefon numaralarını listeleyiniz
select UnitsInStock,Phone
from Products p join Suppliers s
				on p.SupplierID = s.SupplierID
where UnitsInStock=0 and Discontinued='true'
--Taşınan siparişlerin hangi kargo firması ile taşındığını kargo firmasının ismi ile belirtiniz.
select distinct CompanyName
from Orders o join Shippers s
			  on o.ShipVia = s.ShipperID

--İndirimli gönderdiğim siparişlerdeki ürün adlarını, birim fiyatını ve indirim tutarını gösterin
select ProductName,p.UnitPrice,(od.UnitPrice*od.Quantity*od.Discount) as DiscountValue
from [Order Details] od  join Products p
			             on od.ProductID =p.ProductID
where od.Discount>0
--Amerikali tedarikçilerden alinmis olan urunleri gosteriniz...
select ProductName
from Suppliers s join Products p
				 on s.SupplierID = p.SupplierID
where Country ='USA'
--Speedy Express ile tasinmis olan siparisleri gosteriniz...
select OrderID
from Orders o join Shippers s
			  on o.ShipVia=s.ShipperID
where CompanyName = 'speedy express'
--Siparislerimin hangi müsteriye ait oldugunu listeleyiniz. Raporda OrderID ve Müsteri isimleri ve kontakt kuracagim kisinin ismi listelensin. 
select OrderID,CompanyName,ContactName
from orders o join Customers c
			  on o.CustomerID =c.CustomerID


--Siparis kalemlerindeki  ürünlerimin isimleri ve kaçar adet siparis verildigindi OrderId leri ile listeleyiniz
select od.OrderID,ProductName,UnitsOnOrder
from Products p join [Order Details] od 
			  on od.ProductID = p.ProductID
where UnitsOnOrder>0
			  

--Territories tablosundaki bölge tanimlarinin hangi bölgeye ait olduklarini bölgelerin isimleri ile listeleyiniz.
select distinct TerritoryDescription,RegionDescription
from Territories t full join Region r
				   on t.RegionID = r.RegionID

--Chai ürününü tedarik ettigim tedarikçimin ismini, adresini ve telefon numarasini listeleyiniz
select CompanyName,[Address],Phone
from Products p full join Suppliers s on p.SupplierID = s.SupplierID
				
where ProductName = 'chai'
			



