SET DEFINE OFF;

ALTER SESSION SET CURRENT_SCHEMA = UNIFIED_USE;

INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT COALESCE(MAX (REFDATAITEM_ID) + 1, 1) FROM REFDATAITEM),
1, 'action.java.processcontinuity', SYSDATE, 'JSON',
'{
    "className": "com.celfocus.ufe.processcontinuity.business.service.ProcessContinuity",
    "application": "processcontinuity"
}', 1);
  
INSERT INTO ROUTE 
(ID, NAME, MATCHING_SCRIPT, ACTION_CONFIGURATION, IS_PUBLIC, ORCH_EVAL,
CREATION_DATE, CREATION_USER, LAST_UPDATE_DATE, LAST_UPDATE_USER)
VALUES (COALESCE((SELECT MAX (ID) + 1 FROM ROUTE), 1),
'processcontinuity', 'targetIs("/services/processcontinuity")',
'["java.processcontinuity"]', 1,
NULL, SYSDATE, 'DFC', SYSDATE, 'DFC');

COMMIT;