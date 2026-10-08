# ProcrastinatorProgrammer is a 3-part docker-compose scripting challenge served
# over raw TCP (parts on 21201/21202/21203). `pwnmake check` starts it, runs the
# solver, and tears it down.
#
# The bundled autosolver solves all three parts and prints the combined flag. It
# is pointed at the three host-published ports and told to use localhost and run
# once.
CHECK_TIMEOUT := 180
$(call ctf_check_tcp_slow,$(DIR),21201,env CHALLENGE_1_PORT=21201 CHALLENGE_2_PORT=21202 CHALLENGE_3_PORT=21203 python3 autosolver/solver.py --localhost --no-repeat --skip-first-sleep)
