

with

camid_email AS (
SElECT

camid,MAX(EmailAddresse) AS EmailAddresse
,a.BasicSignons

from
RSM_DM.[RSM].FDM_LDAP_Export_All A

where camid is not null
--and BasicSignons = 'tflau'
and BasicSignons not like '%test%'
and EmailAddresse like '%alba%'

GROUP BY camid,a.BasicSignons
--having MAX(EmailAddresse) IS NULL


)




  SELECT


       count( master.dbo.GetUserFromEmail (cam.EmailAddresse))  AS login_cnt
	  ,cam.EmailAddresse
      ,TRY_CAST( c.COGIPF_LOCALTIMESTAMP  AS DATE) AS[Execution_Datum]

   -- ,f.[Kunde]
   -- ,f.[Security_Filter]

  FROM (


SELECT [COGIPF_HOST_IPADDR]
  , [COGIPF_CAMID]
  , [COGIPF_USERID]
  , [COGIPF_STATUS]
  , [COGIPF_SESSIONID]
  , MIN([COGIPF_LOCALTIMESTAMP]) AS [COGIPF_LOCALTIMESTAMP]
  , MIN([COGIPF_LOCALTIMESTAMP_Logon]) AS [COGIPF_LOCALTIMESTAMP_Logon]
  --Auto Logoff führt zu neuer SessionID , BSp 62BD577F0F098369855AAB9575C8F197D8FF976B49BC586D93F17A311CA627FB -> 62CE4595EC6A180B7C42FA53649C515D8E7E1A82908A19A3B0F0672A80DCBB12
  , COALESCE(MAX([COGIPF_LOCALTIMESTAMP_Logoff]), CASE WHEN GETDATE() > DATEADD(MI, +30, MIN([COGIPF_LOCALTIMESTAMP_Logon])) THEN

  DATEADD(MI, +30, MIN([COGIPF_LOCALTIMESTAMP_Logon])) ELSE NULL END) AS [COGIPF_LOCALTIMESTAMP_Logoff]
  , 1 AS Nbr_Of_Logins



  FROM (

  SELECT [COGIPF_HOST_IPADDR]
  ,[COGIPF_CAMID]
  ,[COGIPF_USERID]
  --,[COGIPF_LOGON_OPERATION]
  ,[COGIPF_STATUS]
  ,[COGIPF_SESSIONID]
  ,[COGIPF_LOCALTIMESTAMP]
  , CASE WHEN [COGIPF_LOGON_OPERATION] = 'Logon' THEN [COGIPF_LOCALTIMESTAMP] ELSE NULL END AS [COGIPF_LOCALTIMESTAMP_Logon]
  , CASE WHEN [COGIPF_LOGON_OPERATION] = 'Logoff' THEN [COGIPF_LOCALTIMESTAMP] ELSE NULL END  AS [COGIPF_LOCALTIMESTAMP_Logoff]


--, CASE WHEN [COGIPF_LOGON_OPERATION] = 'Logoff' THEN 1 ELSE 0 END AS AUto_Logoff --62BD577F0F098369855AAB9575C8F197D8FF976B49BC586D93F17A311CA627FB




											  FROM   Cognos_11_RSMMetrics_Audit."dbo"."COGIPF_USERLOGON" c

											  JOIN  camid_email cam
                                                on  c.COGIPF_CAMID LIKE  '%' + cam.camid+'%'


   											 WHERE  1=1
											 --AND c."COGIPF_USERNAME" LIKE  ('Windirsch%')
										--	 and [COGIPF_SESSIONID]='DE6B5FA47871248DFD68F6AD362EE29850D4EE14260E84D6A463B2DF6BB3D17C'

										--- Ausschluss Schedules
											 AND [COGIPF_SESSIONID] NOT IN (SELECT [COGIPF_SESSIONID] FROM [Cognos_11_RSMMetrics_Audit].[dbo].[COGIPF_RUNREPORT]



											 WHERE [COGIPF_STATUS] = 'Success' AND [COGIPF_TARGET_TYPE] NOT IN ('Report BatchReportService')
											 )

											 --and [COGIPF_LOCALTIMESTAMP] >= '01.09.2024' and [COGIPF_LOCALTIMESTAMP] < '20.09.2024'

											 and convert(datetime2,[COGIPF_LOCALTIMESTAMP]) >= '2024-10-23 10:00:00'
										

											 ) base

											 GROUP BY [COGIPF_HOST_IPADDR]
  ,[COGIPF_CAMID]
  ,[COGIPF_USERID]
  ,[COGIPF_STATUS]
  ,[COGIPF_SESSIONID]
  --, [COGIPF_LOCALTIMESTAMP]

  --ORDER BY [COGIPF_LOCALTIMESTAMP] DESC
  ) c

  JOIN  camid_email cam
   on  c.COGIPF_CAMID LIKE  '%' + cam.camid+'%'


  GROUP BY

      TRY_CAST( c.COGIPF_LOCALTIMESTAMP  AS DATE),
	  cam.EmailAddresse
	  order by 2