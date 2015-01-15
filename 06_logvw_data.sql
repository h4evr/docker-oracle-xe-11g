ALTER SESSION SET CURRENT_SCHEMA = UNIFIED_LOG;

INSERT INTO CFG_CRITERIA (
   ID, NAME, TYPE, REGEX, MASK_TYPE, MASK) 
VALUES ( CFG_CRITERIA_SEQ.nextVal,
 'Password',
 'mask', '<[P|p]assword>([^<]+)</[P|p]assword>', 'all', '*');
 
 INSERT INTO CFG_CRITERIA (
   ID, NAME, TYPE, REGEX, STATUS_MATCH, STATUS_OUTPUT) 
VALUES ( CFG_CRITERIA_SEQ.nextVal,
 'SUCCESS',
 'status', '<StatusCode>(\w+)</StatusCode>', 'OK|WARNING', 1);
 
 INSERT INTO CFG_CRITERIA (
   ID, NAME, TYPE, REGEX, STATUS_MATCH, STATUS_OUTPUT) 
VALUES ( CFG_CRITERIA_SEQ.nextVal,
 'ERROR',
 'status', '<StatusCode>(\w+)</StatusCode>', 'ERROR', -1);
 
 INSERT INTO CFG_CRITERIA (
   ID, NAME, TYPE, REGEX) 
VALUES ( CFG_CRITERIA_SEQ.nextVal,
 'MSISDN',
 'parameter', '<MSISDN>(\d+)</MSISDN>');
 
 COMMIT;