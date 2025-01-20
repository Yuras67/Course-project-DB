CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'SecuryP5';

CREATE CERTIFICATE SecuryCertificate
    WITH SUBJECT = 'SecurityCertificate';

CREATE SYMMETRIC KEY DataEncryptionKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE SecuryCertificate;

OPEN SYMMETRIC KEY DataEncryptionKey
    DECRYPTION BY CERTIFICATE SecuryCertificate;

CREATE TABLE UsersSys (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Login VARCHAR(50),
    EncryptedPassword VARBINARY(MAX)
);

OPEN SYMMETRIC KEY DataEncryptionKey
    DECRYPTION BY CERTIFICATE SecuryCertificate;

INSERT INTO UsersSys (Login, EncryptedPassword)
VALUES
    ('Admin', ENCRYPTBYKEY(KEY_GUID('DataEncryptionKey'), 'AdP5')),
    ('Client', ENCRYPTBYKEY(KEY_GUID('DataEncryptionKey'), 'ClP5')),
    ('Manager', ENCRYPTBYKEY(KEY_GUID('DataEncryptionKey'), 'MgP5')),
	('Creator', ENCRYPTBYKEY(KEY_GUID('DataEncryptionKey'), 'MgP5'));

CLOSE SYMMETRIC KEY DataEncryptionKey;

SELECT Login, EncryptedPassword
FROM dbo.UsersSys;

SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'UsersSys';

INSERT INTO dbo.UsersSys (Login, EncryptedPassword)
VALUES
    ('Admin', ENCRYPTBYKEY(KEY_GUID('DataEncryptionKey'), 'AdP5')),
    ('Client', ENCRYPTBYKEY(KEY_GUID('DataEncryptionKey'), 'ClP5')),
    ('Manager', ENCRYPTBYKEY(KEY_GUID('DataEncryptionKey'), 'MgP5')),
	('Creator', ENCRYPTBYKEY(KEY_GUID('DataEncryptionKey'), 'MgP5'));