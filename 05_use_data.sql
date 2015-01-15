SET DEFINE OFF;

-- Jump to USE schema
ALTER SESSION SET CURRENT_SCHEMA = UNIFIED_USE;

-- Add redis configuration
INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT COALESCE(MAX (REFDATAITEM_ID) + 1, 1) FROM REFDATAITEM),
1, 'configuration.redis', SYSDATE, 'JSON',
'{
    "host": "redisdev1",
    "host_act": "redisact1",
    "host_prd": "redisprod1",
    "port": 6379,
    "port_act": 6379,
    "port_prd": 6379,
    "timeout": 2000
}', 1);

-- Add gate keeper configuration
INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX(REFDATAITEM_ID) + 1 FROM REFDATAITEM),
1, 'configuration.gateKeeper', sysdate, 'JSON',
'{
    "className": "com.celfocus.use.uam.services.SessionManagement",
    "application": "login"
}', 1);

-- Add basic RefData action
INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX (REFDATAITEM_ID) + 1 FROM REFDATAITEM),
1, 'action.refdata.refdata', SYSDATE, 'JSON',
'{
    "cached": "false",
    "cacheTimeout": 60
}', 1);

-- Add route to access reference data
INSERT INTO ROUTE 
(ID, NAME, MATCHING_SCRIPT, ACTION_CONFIGURATION, IS_PUBLIC, ORCH_EVAL,
CREATION_DATE, CREATION_USER, LAST_UPDATE_DATE, LAST_UPDATE_USER)
VALUES (COALESCE((SELECT MAX (ID) + 1 FROM ROUTE), 1),
'getRefData', '(targetIs("/services") or targetIs("/services/ufe")) and payloadHas("getRefData") or targetIs("/services/getRefData")',
'["refdata.refdata"]', 1,
NULL, SYSDATE, 'DFC', SYSDATE, 'DFC');

-- Add log action
INSERT INTO REFDATAITEM
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX (REFDATAITEM_ID) + 1 FROM REFDATAITEM),
1, 'action.log.service', SYSDATE, 'JSON',
'{}', 1);

-- Add log route
INSERT INTO ROUTE 
(ID, NAME, MATCHING_SCRIPT, ACTION_CONFIGURATION, IS_PUBLIC, ORCH_EVAL,
CREATION_DATE, CREATION_USER, LAST_UPDATE_DATE, LAST_UPDATE_USER)
VALUES ((SELECT MAX (ID) + 1 FROM ROUTE),
'log_service', 'targetIs("/services/log")',
'["log.service"]', 1,
NULL, SYSDATE, 'DFC', SYSDATE, 'DFC');

COMMIT;