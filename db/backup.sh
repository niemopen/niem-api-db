#!/bin/bash

pg_dump \
  --username=postgres \
  --password=postgres \
  --data-only \
  --format=plain \
  --file=db/export.sql \
  --disable-triggers \
  niem-api-v2
