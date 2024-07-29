-- sql server: Windows認証のログインユーザーに権限を付与

use MySample

bulk insert
    [MySample].[dbo].[customer]
from
    'C:\Users\shins\mydev\learn\sqlserver\bulkinsert\insert_utf8.csv'
with(
    FORMAT = 'CSV',
    FIRSTROW = 1,
    DATAFILETYPE = 'char',
    CODEPAGE = '65001',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
