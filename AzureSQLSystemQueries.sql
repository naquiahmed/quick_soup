
--select * from sys.resource_stats where database_name not like '%[0-9]%' order by end_time desc
select * from sys.resource_stats order by end_time desc
select * from sys.database_service_objectives order by database_id
select * from sys.databases order by database_id
select * from sys.database_connection_stats order by end_time desc
select * from sys.database_firewall_rules
select * from sys.firewall_rules order by 1 desc
select * from sys.database_usage
select * from sys.elastic_pool_resource_stats
select * from sys.event_log order by 1 desc
select * from sys.resource_usage order by storage_in_megabytes desc
select * from sys.extended_properties

--select * from sys.pdw_column_distribution_properties
--select * from sys.pdw_database_mappings
