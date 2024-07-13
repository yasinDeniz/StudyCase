/* Author : H.Yasin Deniz*/

/*
�retilen kampanya kodu'nu do�rulamak i�in olu�turulan stored procedure.
8 haneli ve sadece 'ACDEFGHKLMNPRTXYZ234579' karakterlerinin olup olmad���n� kontrol eder.
*/

CREATE PROCEDURE [dbo].[check_code]
    @Code NVARCHAR(8),     -- generates_code stored procedure'�nde olu�an kodlar� do�rulamak i�in girdi 
    @IsValid INT OUT       -- ��k�� parametresi olarak kodun ge�erlili�i. 0 veya 1 d�ner.
AS
BEGIN
    -- karakter seti de�i�keni
    DECLARE @Chars NVARCHAR(30) = 'ACDEFGHKLMNPRTXYZ234579';
	-- burada ge�erli say�yoruz ��nk� kod uzunlu�u 8 karakterden az ise ge�ersiz saymak 
	-- ve IsValid de�erini 0 olarak devam ettirmek i�in.
    SET @IsValid = 1;

    -- kodun uzunlu�u kontrol ediliyor.
    IF LEN(@Code) != 8 
    BEGIN
        -- 8 karakter uzunlu�unda de�il. Ge�ersizdir.
        SET @IsValid = 0;
    END

    -- tan�mlad���m�z karakterlerden olu�up olu�mad��� kontrol ediliyor.
    IF @IsValid = 1 AND @Code LIKE '%[^ACDEFGHKLMNPRTXYZ234579]%'
    BEGIN
        -- kampanya kodu izin verilen karakter setine uymuyor. Ge�ersizdir.
        SET @IsValid = 0;
    END
END
