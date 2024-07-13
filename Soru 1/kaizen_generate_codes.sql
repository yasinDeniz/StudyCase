/* Author : H.Yasin Deniz*/

/*
Kampanya kodu �retmek i�in olu�turulan stored procedure.
8 haneli ve sadece 'ACDEFGHKLMNPRTXYZ234579' karakterlerini kullanacak
1000 adet kod �retir.
*/

CREATE PROCEDURE [dbo].[generate_codes]
AS
BEGIN
    -- kodda kullan�lacak karakterlerin t�m�
    DECLARE @Chars NVARCHAR(30) = 'ACDEFGHKLMNPRTXYZ234579';
    -- 8 haneli kod de�i�keni
    DECLARE @Code NVARCHAR(8);
    -- Saya�
    DECLARE @Counter INT = 0;
	
	-- istek �zerine �retilecek kod miktar�n� de�i�ken olarak kullanmad�m. 
	-- kesin olarak her seferinde 1000 adet kod �retecektir.
    -- 1000 adet kampanya kodu �retmek i�in d�ng�
    WHILE @Counter < 1000
    BEGIN
        -- kod s�f�rlama
        SET @Code = '';

        -- 8 karakterli kod �retilecek. 
		-- buradaki i�lem code de�i�keninin uzunlu�u 8 karakter olana kadar
		-- chars de�i�kenindeki tan�ml� karakterlerden birisini rastgele 
		-- olarak karakter atar ve 8 haneli bir kod �rettikten sonra 
		-- bir sonraki kodu �retmeye ge�er.
        WHILE LEN(@Code) < 8
        BEGIN
            -- kod �retiliyor (Chars'da tan�mlad���m�z karakterleri kullan�r.)
            SET @Code = @Code + SUBSTRING(@Chars, CHECKSUM(NEWID()) % LEN(@Chars) + 1, 1);
        END

        PRINT @Code

        SET @Counter = @Counter + 1;
    END
END