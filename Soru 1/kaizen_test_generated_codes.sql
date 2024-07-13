/* Author : H.Yasin Deniz*/

/*
Ekstra:
Olu�turulan kampanya kodlar� check edilebiliyordu.
Burada otomatik olarak olu�turulup hatal� olanlar� yazd�r�yoruz.
Olu�turdu�umuz kodlar do�rudan kontrol edildi�i i�in hatal� kod burada tabii ki 0'd�r. 
*/

CREATE PROCEDURE [dbo].[test_generated_codes]
AS
BEGIN
    -- ge�ici tablo 
    CREATE TABLE #GeneratedCodes (Code NVARCHAR(8));
    
    -- kod �retim prosed�r�n� �al��t�r�p sonu�lar� ge�ici tabloya ekliyoruz.
    INSERT INTO #GeneratedCodes (Code)
    EXEC [dbo].[generate_codes];
    
    -- ge�ici tablodaki kodlar� do�rulamak i�in tan�mlar�m�z.
    DECLARE @Code NVARCHAR(8);
    DECLARE @IsValid INT;
    DECLARE @InvalidCount INT = 0;
    
	-- cursor'�m�z
    DECLARE code_cursor CURSOR FOR 
    SELECT Code FROM #GeneratedCodes;
    
    OPEN code_cursor;
    
    FETCH NEXT FROM code_cursor INTO @Code;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- kod do�rulama prosed�r�n� �al��t�r�yoruz.
        EXEC [dbo].[check_code] @Code = @Code, @IsValid = @IsValid OUT;
        
        -- ge�ersiz kod varsa sayac� artt�r�r�z.
        IF @IsValid = 0
        BEGIN
            SET @InvalidCount = @InvalidCount + 1;
            PRINT 'Invalid code: ' + @Code;
        END
        
        FETCH NEXT FROM code_cursor INTO @Code;
    END
    
    CLOSE code_cursor;
    DEALLOCATE code_cursor;
    
    -- ge�ersiz kod say�s�n� yazd�rd�k
    PRINT 'Total invalid codes: ' + CAST(@InvalidCount AS NVARCHAR(10));
    
    -- ge�ici tabloyu sildik
    DROP TABLE #GeneratedCodes;
END
