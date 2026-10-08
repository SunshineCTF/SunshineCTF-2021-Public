# flag-vault-1 is a docker-compose Go (fiber) web challenge.
# `pwnmake check[Web/flag-vault-1]` starts it, runs the solver, and tears it down.
$(call ctf_check_web,$(DIR),21302,flag-vault-1.ctf.hackucf.org,python3 solver.py)
