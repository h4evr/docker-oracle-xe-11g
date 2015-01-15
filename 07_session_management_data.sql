SET DEFINE OFF;
ALTER SESSION SET CURRENT_SCHEMA = UNIFIED_USE;

INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ( COALESCE((SELECT MAX(REFDATAITEM_ID)+1 FROM REFDATAITEM), 1),
 1,  'configuration.login', sysdate,
 'JSON', '{
    "domain": "novabase.intra",
    "server": "adptt101",
    "port": 389,
    "secure": false
 }', 1);

INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX(REFDATAITEM_ID) + 1 FROM REFDATAITEM),
 1, 'action.java.sessionservices', sysdate, 'JSON', 
 '{
    "className": "com.celfocus.use.uam.services.SessionManagement",
    "application": "login"
}', 1);
 
INSERT INTO ROUTE 
(ID, NAME, MATCHING_SCRIPT, ACTION_CONFIGURATION, IS_PUBLIC, ORCH_EVAL,
CREATION_DATE, CREATION_USER, LAST_UPDATE_DATE, LAST_UPDATE_USER)
VALUES (COALESCE((SELECT MAX (ID) + 1 FROM ROUTE), 1),
'sessionservices', 'targetIs("/services/session")',
'["java.sessionservices"]', 1,
 NULL, SYSDATE, 'DFC', SYSDATE, 'DFC');
 
-- Add security session action
INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX(REFDATAITEM_ID) + 1 FROM REFDATAITEM),
1, 'action.security.session', sysdate, 'JSON',
'{
    "useHeaderSessionId": "true",
    "tokenValidationRoute": "sessionservices",
    "payloadTemplate": "{\"read\":{\"id\":\"${sessionId}\"}}",
    "responsePath": "statusCode",
    "validValue": "OK"
}', 1);

-- Add login i18n
INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX(REFDATAITEM_ID) + 1 FROM REFDATAITEM),
1, 'login.i18n.pt', sysdate, 'JSON',
'{}', 1);

INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX(REFDATAITEM_ID) + 1 FROM REFDATAITEM),
1, 'login.i18n.en', sysdate, 'JSON',
'{}', 1);

-- Add getI18nData
INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX(REFDATAITEM_ID) + 1 FROM REFDATAITEM),
1, 'i18n.i18n', SYSDATE, 'JSON',
'{ }', 1);

  
INSERT INTO REFDATAITEM 
(REFDATAITEM_ID, EXPORTABLE, NAME, TIME, TYPE, VALUE, VERSION)
VALUES ((SELECT MAX(REFDATAITEM_ID) + 1 FROM REFDATAITEM),
1, 'action.i18n.i18n', SYSDATE, 'JSON',
'{
  "cached": "false",
  "cacheTimeout": 60,
  "fallbackLanguage": "pt",
  "availableLanguages": {
     "items": [{
         "value": "en",
         "text": "English"
     }, {
         "value": "pt",
         "text": "Português"
     }, {
         "value": "tr",
         "text": "Türkçe"
     }]
  }
}', 1);

INSERT INTO ROUTE 
(ID, NAME, MATCHING_SCRIPT, ACTION_CONFIGURATION, IS_PUBLIC, ORCH_EVAL,
CREATION_DATE, CREATION_USER, LAST_UPDATE_DATE, LAST_UPDATE_USER)
VALUES ((SELECT MAX (ID) + 1 FROM ROUTE),
'getI18nData', '(targetIs("/services") and payloadHas("getI18nData")) or targetIs("/services/getI18nData") ',
'["i18n.i18n"]', 1,
null, sysdate, 'PMC', sysdate, 'PMC');
        
COMMIT;