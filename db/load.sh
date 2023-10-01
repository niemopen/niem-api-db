#!/bin/bash

psql -U postgres -d niem-api-v2 < db/niem.sql
