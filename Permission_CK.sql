select permission_name, state, pr.name
from sys.database_permissions pe
join sys.database_principals pr on pe.grantee_principal_id = pr.principal_id
where pe.class = 1 
    and pe.major_id = object_id('TblSalesForecastAudiDealerWeeklyStatus')
    and pe.minor_id = 0;
