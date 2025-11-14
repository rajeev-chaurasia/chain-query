-- This is the DOWN migration
BEGIN;

DROP TABLE IF EXISTS erc20_transfers;
DROP TABLE IF EXISTS erc721_transfers;
DROP TABLE IF EXISTS indexer_status;

COMMIT;