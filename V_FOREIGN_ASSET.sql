CREATE OR REPLACE VIEW V_FOREIGN_ASSET AS
SELECT
'GOLD' DESCRIP,
NVL(BS.BS_HOME_AMT,0)/1000000 AMOUNT,
TRUNC(UR.UPLD_RPT_REPORTING_PERIOD) UPLDATE
FROM LMSAPP.UPLD_BALANCE_SHEET BS LEFT JOIN LMSAPP.UPLD_REPORT UR ON BS.BS_REPORT_ID = UR.UPLD_RPT_REPORT_ID
WHERE BS.BS_GL_NUMBER LIKE '2212%'

UNION

-----------ASS-FOREIGN EXCHANGE----------
SELECT
'FRN_EXC' DESCRIP ,
NVL(BS.BS_HOME_AMT,0)/1000000 AMOUNT,
TRUNC(UR.UPLD_RPT_REPORTING_PERIOD) UPLDATE
FROM LMSAPP.UPLD_BALANCE_SHEET BS LEFT JOIN LMSAPP.UPLD_REPORT UR ON BS.BS_REPORT_ID = UR.UPLD_RPT_REPORT_ID
WHERE (BS.BS_GL_NUMBER LIKE '1121%' OR BS.BS_GL_NUMBER LIKE '1123%' OR BS.BS_GL_NUMBER LIKE '1124%')

UNION

---------ASS-- Accounts with foreign bank and nonbank institutions--------
SELECT
-- Accounts with foreign bank and nonbank Institutions
'AC_W_FRN_INST' DESCRIP,
NVL(BS.BS_HOME_AMT,0)/1000000 AMOUNT,
TRUNC(UR.UPLD_RPT_REPORTING_PERIOD) UPLDATE
FROM LMSAPP.UPLD_BALANCE_SHEET BS LEFT JOIN LMSAPP.UPLD_REPORT UR ON BS.BS_REPORT_ID = UR.UPLD_RPT_REPORT_ID
WHERE (BS.BS_GL_NUMBER LIKE '121211%' OR BS.BS_GL_NUMBER LIKE '121212%'
OR BS.BS_GL_NUMBER LIKE '121311%' OR BS.BS_GL_NUMBER LIKE '121312%'
OR BS.BS_GL_NUMBER LIKE '121411%' OR BS.BS_GL_NUMBER LIKE '121412%' OR BS.BS_GL_NUMBER LIKE '121421%'
OR BS.BS_GL_NUMBER LIKE '121422%' OR BS.BS_GL_NUMBER LIKE '122212%' OR BS.BS_GL_NUMBER LIKE '122312%'
OR BS.BS_GL_NUMBER LIKE '122411%' OR BS.BS_GL_NUMBER LIKE '122412%' OR BS.BS_GL_NUMBER LIKE '122413%'
OR BS.BS_GL_NUMBER LIKE '122421%' OR BS.BS_GL_NUMBER LIKE '122422%' OR BS.BS_GL_NUMBER LIKE '129301%'
OR BS.BS_GL_NUMBER LIKE '141211%' OR BS.BS_GL_NUMBER LIKE '141411%' OR BS.BS_GL_NUMBER LIKE '141422%'
OR BS.BS_GL_NUMBER LIKE '142211%' OR BS.BS_GL_NUMBER LIKE '142411%' OR BS.BS_GL_NUMBER LIKE '142422%'
OR BS.BS_GL_NUMBER LIKE '149301%' OR BS.BS_GL_NUMBER LIKE '149103%' OR BS.BS_GL_NUMBER LIKE '169302%')

UNION ALL

SELECT
-- Accounts with foreign bank and nonbank Institutions
'AC_W_FRN_INST' DESCRIP,
NVL(BS.BS_HOME_AMT,0)/1000000 * (-1) AMOUNT,
TRUNC(UR.UPLD_RPT_REPORTING_PERIOD) UPLDATE
FROM LMSAPP.UPLD_BALANCE_SHEET BS LEFT JOIN LMSAPP.UPLD_REPORT UR ON BS.BS_REPORT_ID = UR.UPLD_RPT_REPORT_ID
WHERE (BS.BS_GL_NUMBER LIKE '329101%' OR BS.BS_GL_NUMBER LIKE '329301%')

UNION ALL
-----------ASS--- Other credits to nonresidents---------------
SELECT

-- Other credits to nonresidents
'OTH_CR_NON_RESNT' DESCRIP,
NVL(BS.BS_HOME_AMT,0)/1000000 AMOUNT,
TRUNC(UR.UPLD_RPT_REPORTING_PERIOD) UPLDATE
FROM LMSAPP.UPLD_BALANCE_SHEET BS LEFT JOIN LMSAPP.UPLD_REPORT UR ON BS.BS_REPORT_ID = UR.UPLD_RPT_REPORT_ID
WHERE (BS.BS_GL_NUMBER LIKE '1457%' OR BS.BS_GL_NUMBER LIKE '1467%' OR BS.BS_GL_NUMBER LIKE '3493%')

UNION

------------------------SDR HOLDINGS----------------------
SELECT
'SDR_HOLDING' DESCRIP,
RAT.SCR_EXCH_RATE * RAT.SCR_SDR_HOLDING AMOUNT,
TRUNC(RAT.SCR_EFECT_DATE) UPLDATE
FROM MA_SOURCE_RATE RAT

UNION

SELECT
'LPCO_KHR' DESCRIP,
NVL(BS.BS_HOME_AMT,0)/1000000 AMOUNT,
TRUNC(UR.UPLD_RPT_REPORTING_PERIOD) UPLDATE
FROM LMSAPP.UPLD_BALANCE_SHEET BS LEFT JOIN LMSAPP.UPLD_REPORT UR ON BS.BS_REPORT_ID = UR.UPLD_RPT_REPORT_ID
WHERE (BS.BS_GL_NUMBER LIKE '175612000%' OR BS.BS_GL_NUMBER LIKE '175614000%' OR BS.BS_GL_NUMBER LIKE '176612000%'
OR BS.BS_GL_NUMBER LIKE '176614000%');
