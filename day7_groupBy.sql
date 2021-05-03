
 /*============================= GROUP BY =====================================
    
    GROUP BY cümleci?i bir SELECT ifadesinde sat?rlar?, sutunlar?n de?erlerine 
    göre özet olarak gruplamak için kullan?l?r. 
   
    GROUP BY cümlece?i her grup ba??na bir sat?r döndürür. 
    
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate 
    fonksiyonlar? ile birlikte kullan?l?r.
    
==============================================================================*/ 
      
    CREATE TABLE manav 
    (
        isim varchar2(50), 
        urun_adi varchar2(50), 
        urun_miktari number(9) 
    );
    
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', '', 2);
    
/* -----------------------------------------------------------------------------
  ORNEK1: kisi ismine göre sat?lan toplam meyve miktarlar?n? gösteren sorguyu 
  yaz?n?z.
------------------------------------------------------------------------------*/  
    SELECT isim, SUM(urun_miktari) AS toplam_urun 
    FROM manav
    GROUP BY isim;
   
/* ----------------------------------------------------------------------------
  ORNEK2: sat?lan meyve türüne (urun_adi) göre urun alan ki?i say?s?n? gösteren
  sorguyu yaz?n?z. NULL olarak girilen meyveyi listelemesin.
-----------------------------------------------------------------------------*/ 
    -- GROUP by ile birlikte WHERE cümleci?i kullan?labilir.
        
    SELECT urun_adi, COUNT(isim) AS kisi_sayisi
    FROM manav
    WHERE urun_adi IS NOT NULL
    GROUP BY urun_adi;
    
    SELECT * FROM manav;
    
   
/* ----------------------------------------------------------------------------
  ORNEK3: sat?lan meyve türüne (urun_adi) göre sat?lan (urun_miktari )MIN ve 
  MAX urun miktarlarini, MAX urun miktarina göre s?ralayarak listeyen sorguyu 
  yaz?n?z.
-----------------------------------------------------------------------------*/ 
    SELECT urun_adi,MIN(urun_miktari) min_miktar, MAX(urun_miktari) maks_miktar
    FROM manav
    WHERE urun_adi IS NOT NULL
    GROUP BY urun_adi
    ORDER BY MAX(urun_miktari) DESC;
    
    SELECT urun_adi, MIN(urun_miktari) min_miktar, MAX(urun_miktari) max_miktar
    FROM manav
    WHERE urun_adi IS NOT NULL
    Group By urun_adi
    ORDER BY MAX(urun_adi) DESC;
    
    
/* ----------------------------------------------------------------------------
  ORNEK4: kisi ismine ve urun ad?na göre sat?lan ürünlerin toplam?n? 
  grupland?ran ve isime göre ters s?ras?da listeyen sorguyu yaz?n?z.
 -----------------------------------------------------------------------------*/ 
     
     SELECT isim, urun_adi, SUM(urun_miktari) as toplam_miktar
     FROM manav
     WHERE urun_adi IS NOT NULL
     GROUP BY isim, urun_adi
     ORDER BY isim DESC;
     
/* ----------------------------------------------------------------------------
  ORNEK5: kisi ismine ve urun ad?na göre sat?lan ürünlerin toplam?n? bulan ve
  ve bu toplam de?eri 3 ve fazlas? olan kay?tlar? toplam urun miktarlarina göre
  ters siralayarak listeyen sorguyu yaz?n?z.
 -----------------------------------------------------------------------------*/  
     SELECT isim, urun_adi, SUM(urun_miktari) as toplam_miktar
     FROM manav
     GROUP BY isim, urun_adi
     HAVING SUM(urun_miktari) >= 3
     ORDER BY SUM(urun_miktari) DESC;
     
    -- AGGREGATE fonksiyonlar? ile ilgili bir ko?ul koymak için GROUP BY'dan 
    -- sonra HAVING cümleci?i kullan?l?r.
 
 /* ----------------------------------------------------------------------------
  ORNEK6: sat?lan urun_adi'na göre MAX urun say?lar?n? s?ralayarak listeyen 
  sorguyu yaz?n?z. NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktar?na 
  e?it olmayan kay?tlar? listelemelidir.
 -----------------------------------------------------------------------------*/    
     SELECT urun_adi, MAX(urun_miktari)
     FROM manav
     GROUP BY urun_adi
     HAVING MAX(urun_miktari) <> MIN(urun_miktari)
     ORDER BY MAX(urun_miktari);


 /*============================= DISTINCT =====================================
    
    DISTINCT cümleci?i bir SORGU ifadesinde benzer olan sat?rlar? flitrelemek
    için kullan?l?r. Dolay?s?yla seçilen sutun yada sutunlar için benzersiz veri
    içeren sat?rlar olu?turmaya yarar.
   
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_ad?;
==============================================================================*/
    
     
/* ----------------------------------------------------------------------------
  ORNEK1: sat?lan farkl? meyve türlerinin say?s?n? listeyen sorguyu yaz?n?z.
-----------------------------------------------------------------------------*/   
    
    SELECT COUNT(DISTINCT urun_adi) AS urun_sayisi 
    FROM manav;

/* -----------------------------------------------------------------------------
  ORNEK2: sat?lan meyve ve isimlerin farkl? olanlar?n? listeyen sorguyu yaz?n?z.
------------------------------------------------------------------------------*/
     SELECT DISTINCT urun_adi,isim   -- 2 sutun icin beraber degerlendirirek
                                     -- benzerli olanlar? cikariyor.
     FROM manav; 
     
/* ----------------------------------------------------------------------------
  ORNEK3: sat?lan meyvelerin urun_mikarlarinin benzersiz  olanlar?n?n 
  toplamlarini listeyen sorguyu yaz?n?z.
-----------------------------------------------------------------------------*/     
     SELECT SUM(DISTINCT urun_miktari) AS urun_sayisi 
     FROM manav;