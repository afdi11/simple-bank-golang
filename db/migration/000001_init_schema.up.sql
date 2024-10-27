-- Create the accounts table
CREATE TABLE "accounts" (
    "id" bigserial PRIMARY KEY,
    "owner" varchar NOT NULL,
    "balance" bigint NOT NULL,
    "currency" varchar NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now())
);

-- Create the entries table
CREATE TABLE "entries" (
    "id" bigserial PRIMARY KEY,
    "account_id" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now())
);

-- Create the transfers table
CREATE TABLE "transfers" (
    "id" bigserial PRIMARY KEY,
    "from_account_id" bigint NOT NULL,
    "to_account_id" bigint NOT NULL,
    "amount" bigint NOT NULL,
    "created_at" timestamptz NOT NULL DEFAULT (now())
);

-- Add foreign key constraints for entries
ALTER TABLE "entries" 
ADD FOREIGN KEY ("account_id") REFERENCES "accounts"("id");

-- Add foreign key constraints for transfers
ALTER TABLE "transfers" 
ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts"("id");

ALTER TABLE "transfers" 
ADD FOREIGN KEY ("to_account_id") REFERENCES "accounts"("id");

-- Create indexes for optimization
CREATE INDEX ON "accounts" ("owner");

CREATE INDEX ON "entries" ("account_id");

CREATE INDEX ON "transfers" ("from_account_id");

CREATE INDEX ON "transfers" ("to_account_id");

CREATE INDEX ON "transfers" ("from_account_id", "to_account_id");

-- Add comments to describe column behavior
COMMENT ON COLUMN "accounts"."id" IS 'primary key';
COMMENT ON COLUMN "accounts"."owner" IS 'owner of the account';
COMMENT ON COLUMN "accounts"."balance" IS 'current balance of the account';
COMMENT ON COLUMN "accounts"."currency" IS 'currency of the account';
COMMENT ON COLUMN "accounts"."created_at" IS 'timestamp when the account was created';

COMMENT ON COLUMN "entries"."id" IS 'primary key';
COMMENT ON COLUMN "entries"."account_id" IS 'foreign key to accounts table';
COMMENT ON COLUMN "entries"."amount" IS 'can be negative or positive';
COMMENT ON COLUMN "entries"."created_at" IS 'timestamp when the entry was created';

COMMENT ON COLUMN "transfers"."id" IS 'primary key';
COMMENT ON COLUMN "transfers"."from_account_id" IS 'foreign key to accounts table for the sender';
COMMENT ON COLUMN "transfers"."to_account_id" IS 'foreign key to accounts table for the receiver';
COMMENT ON COLUMN "transfers"."amount" IS 'must be positive';
COMMENT ON COLUMN "transfers"."created_at" IS 'timestamp when the transfer was created';
