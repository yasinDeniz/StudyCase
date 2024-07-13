/* Author : H.Yasin Deniz*/

/*
Ekstra:
Oluþturulan kampanya kodlarý check edilebiliyordu.
Burada otomatik olarak oluþturulup hatalý olanlarý yazdýrýyoruz.
Oluþturduðumuz kodlar doðrudan kontrol edildiði için hatalý kod burada tabii ki 0'dýr. 
*/

CREATE PROCEDURE [dbo].[test_generated_codes]
AS
BEGIN
    -- geçici tablo 
    CREATE TABLE #GeneratedCodes (Code NVARCHAR(8));
    
    -- kod üretim prosedürünü çalýþtýrýp sonuçlarý geçici tabloya ekliyoruz.
    INSERT INTO #GeneratedCodes (Code)
    EXEC [dbo].[generate_codes];
    
    -- geçici tablodaki kodlarý doðrulamak için tanýmlarýmýz.
    DECLARE @Code NVARCHAR(8);
    DECLARE @IsValid INT;
    DECLARE @InvalidCount INT = 0;
    
	-- cursor'ýmýz
    DECLARE code_cursor CURSOR FOR 
    SELECT Code FROM #GeneratedCodes;
    
    OPEN code_cursor;
    
    FETCH NEXT FROM code_cursor INTO @Code;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- kod doðrulama prosedürünü çalýþtýrýyoruz.
        EXEC [dbo].[check_code] @Code = @Code, @IsValid = @IsValid OUT;
        
        -- geçersiz kod varsa sayacý arttýrýrýz.
        IF @IsValid = 0
        BEGIN
            SET @InvalidCount = @InvalidCount + 1;
            PRINT 'Invalid code: ' + @Code;
        END
        
        FETCH NEXT FROM code_cursor INTO @Code;
    END
    
    CLOSE code_cursor;
    DEALLOCATE code_cursor;
    
    -- geçersiz kod sayýsýný yazdýrdýk
    PRINT 'Total invalid codes: ' + CAST(@InvalidCount AS NVARCHAR(10));
    
    -- geçici tabloyu sildik
    DROP TABLE #GeneratedCodes;
END
