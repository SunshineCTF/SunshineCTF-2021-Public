# typing is a static nginx site with no server-side solve path, so there is no
# automated check to register here (RUNS-NO-SOLVER). See splits/solve.sh for the
# manual solve.

# No check macro to auto-emit the route, so publish the nginx snippet directly.
$(call nginx_service,typing.ctf.hackucf.org,21501)
