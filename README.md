
# NIEM API Database

This project provides the database used by the [NIEM API project](https://github.com/niemopen/niem-api/).  Full NIEM data and schema-only files are available.

## Data

Data and migrations rules are available from NIEM 1.0 to NIEM 6.0.

## Pending

- Type unions and local terminology are not yet available.
- Legacy fields that existed before NIEM 3.0 are not yet available
  - Example: identifying properties that could appear as content, reference, or both
- Additional fields that may be needed to support extension schemas that are not needed by reference schemas (e.g., to support features like `choice`) are not yet available.

## Files

- `niem.backup` - Schemas and data exported via `pg_dump` in the `custom` format with default compression.

- `niem-schemas.sql` - Optional file.  Schema-only export via `pg_dump` in the `plain` format.  A full, schema-only, or data-only restore can be run against the `niem.backup` file.  This file makes it easier to view structural changes via diffs.

## Database schemas

### public

The public schema provides the tables used by the API.  It contains the primary data tables (like `namespace`, `property`, and `type`) as well as corresponding audit tables maintaining the full change history for the data tables as managed by the NIEM API.

### info

The info schema provides supplemental views for the data tables, bringing in key fields from foreign tables for easy reference.

For example:

- The `property` table in the `public` schema contains ids for related types and substitutions groups
- The `property_rels` view in the `info` schema adds qualified type names and qualified substitution group names to the property rows.
- The `property_migrations` view in the `info` schema adds human-readable identifiers for the previous and next versions of each property.

## Restore

**Note: This will overwrite existing schemas and data.**  Preserve any custom content in your database before running a restore (back it up, rename your schemas, restore to a different database, etc.).

**Long options**

```sh
pg_restore --host localhost --port 5432 --username postgres --dbname niem_api_v2 \
  --no-owner --no-privileges --clean --if-exists --verbose niem.backup
```

**Short options**

```sh
pg_restore -h localhost -p 5432 -U postgres -d niem_api_v2 -O -x -c --if-exists -v niem.backup
```

**pgAdmin options**

General tab:

- Format: `Custom or tar`
- Filename: *Select `niem.backup`*

Data Options:

- *Optional*: Select `Only data` or `Only schema` under `Type of objects` for a partial restore.
- Select `Do not save Owner`
- Select `Do not save Privileges`

Query Options:

- Select `Clean before restore`
- Select `Include IF EXISTS clause`

## Back up

**Long options**

```sh
pg_dump --host localhost --port 5432 --username postgres --dbname niem_api_v2 \
 --format c --blobs --encoding UTF8 --no-owner --no-privileges --verbose --file niem.backup
```

**Short options**

```sh
pg_dump -h localhost -p 5432 -U postgres -d niem_api_v2 -O -x -F c -b -E UTF8 -v -f niem.backup
```

**pgAdmin options**

General tab:

- Filename: *Select path*
- Format: `Custom`
- Encoding: `UTF-8`

Data Options:

- Select `Do not save Owner`
- Select `Do not save Privileges`
