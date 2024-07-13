/* Author : H.Yasin Deniz*/

/*
Üretilen kampanya kodu'nu doðrulamak için oluþturulan stored procedure.
8 haneli ve sadece 'ACDEFGHKLMNPRTXYZ234579' karakterlerinin olup olmadýðýný kontrol eder.
*/

CREATE PROCEDURE [dbo].[check_code]
    @Code NVARCHAR(8),     -- generates_code stored procedure'ünde oluþan kodlarý doðrulamak için girdi 
    @IsValid INT OUT       -- çýkýþ parametresi olarak kodun geçerliliði. 0 veya 1 döner.
AS
BEGIN
    -- karakter seti deðiþkeni
    DECLARE @Chars NVARCHAR(30) = 'ACDEFGHKLMNPRTXYZ234579';
	-- burada geçerli sayýyoruz çünkü kod uzunluðu 8 karakterden az ise geçersiz saymak 
	-- ve IsValid deðerini 0 olarak devam ettirmek için.
    SET @IsValid = 1;

    -- kodun uzunluðu kontrol ediliyor.
    IF LEN(@Code) != 8 
    BEGIN
        -- 8 karakter uzunluðunda deðil. Geçersizdir.
        SET @IsValid = 0;
    END

    -- tanýmladýðýmýz karakterlerden oluþup oluþmadýðý kontrol ediliyor.
    IF @IsValid = 1 AND @Code LIKE '%[^ACDEFGHKLMNPRTXYZ234579]%'
    BEGIN
        -- kampanya kodu izin verilen karakter setine uymuyor. Geçersizdir.
        SET @IsValid = 0;
    END
END
