CREATE OR REPLACE VIEW V_LIQ_TOTAL_RESERVED AS
SELECT
--Bank Reserved Account KHR
'BNK_RESV_AC_KHR' DESCRIP
,SUM(NVL(AMOUNT,0) * DECODE(AMTMIN,'',1,-1) /1000000) * (-1) AMOUNT
,CAST(UPLDATE AS DATE) UPLDATE
FROM V_LIQ_MA_SOURCE
WHERE GLM LIKE '2121%1' 
GROUP BY CAST(UPLDATE AS DATE)

UNION

--20 Bank Current Account KHR
SELECT
'BNK_CUR_AC_KHR' DESCRIP
,SUM(NVL(AMOUNT,0) * DECODE(AMTMIN,'',1,-1) /1000000) * (-1) AMOUNT
,CAST(UPLDATE AS DATE) UPLDATE
FROM V_LIQ_MA_SOURCE
WHERE GLM LIKE '21222%1' 
GROUP BY CAST(UPLDATE AS DATE)

UNION

--21 Bank Settlement Account KHR
SELECT
'BNK_SETL_AC_KHR' DESCRIP
,SUM(NVL(AMOUNT,0) * DECODE(AMTMIN,'',1,-1) /1000000) * (-1) AMOUNT
,CAST(UPLDATE AS DATE) UPLDATE
FROM V_LIQ_MA_SOURCE
WHERE GLM LIKE '21223%1' 
GROUP BY CAST(UPLDATE AS DATE)
