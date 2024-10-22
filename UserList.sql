
select * from MIH_Interseroh_DM.MIH_Interseroh.DDM_IS_Security_TM1_Invest
where Email
in
(
'antje.nasr@alba.info'
,'bastian.bache@alba.info'
,'desiree.baumgaertner@alba.info'
,'katharina.schroeder@alba.info'
,'klaus.steinacker@alba.info'
,'matthias.redeker@alba.info'
,'olga.knaus@alba.info'
)
order by Name




select 
username UserName,
mail EmailAdresse,
classname License,
mustchange ,
*
from [192.168.154.51].RSM_DS.rsm.FDS_LDAP_Member
where action in 
(
'ChangePW=Already'
,'ChangePW=Enable')
and username not like '%Test%'
and mail='timea.varga@alba.info'

select * from MIH_Interseroh_DM.MIH_Interseroh.DDM_UR_Users
where EmailAddresse ='timea.varga@alba.info'

select * from MIH_Interseroh_DM.MIH_Interseroh.FDM_UR_User_Report
where Quelle='LOGIN'
and User_Key='yvette.wohlgemuth'



select * from MIH_Interseroh_DM.MIH_Interseroh.DDM_UR_Users
where EmailAddresse in
('thomas.karge@alba.info'
,'olga.knaus@alba.info'
,'anne.bernhardt@alba.info'
,'martin.wirth@alba.info'
,'karic.damon@alba.info'
,'desiree.baumgaertner@alba.info'
,'matthias.redeker@alba.info'
,'katharina.schroeder@alba.info'
,'martin.stärr@alba.info'
,'antje.nasr@alba.info'
,'volker.klingenberg@alba.info'
,'rainer.huettig@alba.info'
,'klaus.steinacker@alba.info'
,'sascha.bleibinhaus@alba.info'
,'bastian.bache@alba.info'
,'denise.bleil@alba.info'
,'corinna.schoenweiler@alba.info'
,'gernot.riedle@alba.info'
,'yvette.wohlgemuth@alba.info')




