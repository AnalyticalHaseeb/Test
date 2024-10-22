select * from RSM_DM.RSM.FDM_Audit_CheckBuilds
where catalog_name='RSM_DM'
and component_starttime>=GETDATE()-2