-- This is the UP migration
BEGIN;

-- Table to store ERC-20 (standard token) transfers
CREATE TABLE IF NOT EXISTS erc20_transfers (
    id SERIAL PRIMARY KEY,
    block_number BIGINT NOT NULL,
    "timestamp" TIMESTAMPTZ NOT NULL,
    tx_hash VARCHAR(66) NOT NULL,
    contract_address VARCHAR(42) NOT NULL,
    from_address VARCHAR(42) NOT NULL,
    to_address VARCHAR(42) NOT NULL,
    -- NUMERIC(78, 0) can store a 256-bit integer
    value NUMERIC(78, 0) NOT NULL 
);

-- Table to store ERC-721 (NFT) transfers
CREATE TABLE IF NOT EXISTS erc721_transfers (
    id SERIAL PRIMARY KEY,
    block_number BIGINT NOT NULL,
    "timestamp" TIMESTAMPTZ NOT NULL,
    tx_hash VARCHAR(66) NOT NULL,
    contract_address VARCHAR(42) NOT NULL,
    from_address VARCHAR(42) NOT NULL,
    to_address VARCHAR(42) NOT NULL,
    -- The key difference: NFTs have a 'token_id', not a 'value'
    token_id NUMERIC(78, 0) NOT NULL
);

-- Table to track the indexer's progress
CREATE TABLE IF NOT EXISTS indexer_status (
    id SERIAL PRIMARY KEY,
    -- We can add 'chain_name' or similar if we go multi-chain
    last_indexed_block BIGINT NOT NULL
);

-- ### INDEXES ###

-- Indexes for ERC-20 table
CREATE INDEX IF NOT EXISTS idx_erc20_from_address ON erc20_transfers(from_address);
CREATE INDEX IF NOT EXISTS idx_erc20_to_address ON erc20_transfers(to_address);
CREATE INDEX IF NOT EXISTS idx_erc20_contract_address ON erc20_transfers(contract_address);

-- Indexes for ERC-721 table
CREATE INDEX IF NOT EXISTS idx_erc721_from_address ON erc721_transfers(from_address);
CREATE INDEX IF NOT EXISTS idx_erc721_to_address ON erc721_transfers(to_address);
CREATE INDEX IF NOT EXISTS idx_erc721_contract_address ON erc721_transfers(contract_address);

COMMIT;