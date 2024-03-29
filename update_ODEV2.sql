 CREATE TABLE calisanlar
    (
        id CHAR(4),
        isim VARCHAR2(50),
        maas NUMBER(5),
        CONSTRAINT id_pk PRIMARY KEY (id)
    );

    INSERT INTO calisanlar VALUES('1001', 'Ahmet Aslan', 7000);
    INSERT INTO calisanlar VALUES( '1002', 'Mehmet Y?lmaz' ,12000);
    INSERT INTO calisanlar VALUES('1003', 'Meryem ', 7215);
    INSERT INTO calisanlar VALUES('1004', 'Veli Han', 5000);
 
    CREATE TABLE aileler
    (
        id CHAR(4),
        cocuk_sayisi VARCHAR2(50),
        ek_gelir NUMBER(5),
        CONSTRAINT id_fk FOREIGN KEY (id) REFERENCES calisanlar(id)
    );
    
    INSERT INTO aileler VALUES('1001', 4, 2000);
    INSERT INTO aileler VALUES('1002', 2, 1500);
    INSERT INTO aileler VALUES('1003', 1, 2200);
    INSERT INTO aileler VALUES('1004', 3, 2400);
    
       
    -- 2) Veli Han'?n maa??na %20 zam yap?n?z.
    UPDATE calisanlar
    SET maas = maas * 1.2
    WHERE isim = 'Veli Han';
    
   --3) Maa?? ortalaman?n alt?nda olanlara %20 zam yap?n?z.
    UPDATE calisanlar
    SET maas = maas * 1.2
    WHERE maas <  (SELECT AVG(maas) 
                   FROM calisanlar); 
                
    SELECT * FROM calisanlar;
    
    
    -- 4) calisanlar?n isim ve cocuk_sayisi'ni listeyen sorguyu yaz?n?z.
    SELECT isim, (SELECT cocuk_sayisi FROM aileler
                 WHERE calisanlar.id = aileler.id) as cocuk_sayisi
    FROM calisanlar;
    
    -- Alternatif yol
    SELECT isim, cocuk_sayisi FROM calisanlar, aileler
    WHERE calisanlar.id = aileler.id; 
 
        
    -- 5) calisanlar' ?n  isim ve toplam_gelir'lerini g�steren bir sorgu yaz?n?z. 
          -- toplam_gelir = calisanlar.maas + aileler.ek_gelir 
    
    SELECT id, isim, (SELECT maas + ek_gelir FROM aileler
                      WHERE calisanlar.id = aileler.id) as toplam_gelir
    FROM calisanlar;
    
    -- Alternatif k?sa yol
    SELECT isim,(maas+ek_gelir) as toplam_gelir
    FROM calisanlar, aileler  
    WHERE calisanlar.id = aileler.id;
     
    -- 6) e?er bir ailenin ki?i ba?? geliri 2000 TL den daha az ise o �al??an?n
           -- maa??na ek %10 aile yard?m zamm? yap?n?z. 
           -- kisi_basi_gelir = toplam_gelir / cocuk_sayisi + 2 (anne ve baba)
    
    UPDATE calisanlar 
    SET maas = maas * 1.1    
    WHERE (SELECT (maas + ek_gelir)/(cocuk_sayisi + 2) FROM aileler
          WHERE calisanlar.id = aileler.id) < 2000;  
    