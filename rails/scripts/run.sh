#!/usr/bin/env bash

set -e

## generate assets
#(cd /app; rake assets:precompile)
## execute migrate; can't execute in Dockerfile because of mysql connection error.
#(cd /app; rake db:migrate)
## Remove pid file
#rm -f /tmp/unicorn.pid

#
# Run container foreground
#
#while condition ; do
#  sleep 30
#done
(cd /app; rails server -b 0.0.0.0)
#(cd /app; foreman start -f $PROCFILE)
