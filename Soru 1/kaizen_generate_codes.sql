/* Author : H.Yasin Deniz*/

/*
Kampanya kodu üretmek için oluþturulan stored procedure.
8 haneli ve sadece 'ACDEFGHKLMNPRTXYZ234579' karakterlerini kullanacak
1000 adet kod üretir.
*/

CREATE PROCEDURE [dbo].[generate_codes]
AS
BEGIN
    -- kodda kullanýlacak karakterlerin tümü
    DECLARE @Chars NVARCHAR(30) = 'ACDEFGHKLMNPRTXYZ234579';
    -- 8 haneli kod deðiþkeni
    DECLARE @Code NVARCHAR(8);
    -- Sayaç
    DECLARE @Counter INT = 0;
	
	-- istek üzerine üretilecek kod miktarýný deðiþken olarak kullanmadým. 
	-- kesin olarak her seferinde 1000 adet kod üretecektir.
    -- 1000 adet kampanya kodu üretmek için döngü
    WHILE @Counter < 1000
    BEGIN
        -- kod sýfýrlama
        SET @Code = '';

        -- 8 karakterli kod üretilecek. 
		-- buradaki iþlem code deðiþkeninin uzunluðu 8 karakter olana kadar
		-- chars deðiþkenindeki tanýmlý karakterlerden birisini rastgele 
		-- olarak karakter atar ve 8 haneli bir kod ürettikten sonra 
		-- bir sonraki kodu üretmeye geçer.
        WHILE LEN(@Code) < 8
        BEGIN
            -- kod üretiliyor (Chars'da tanýmladýðýmýz karakterleri kullanýr.)
            SET @Code = @Code + SUBSTRING(@Chars, CHECKSUM(NEWID()) % LEN(@Chars) + 1, 1);
        END

        PRINT @Code

        SET @Counter = @Counter + 1;
    END
END