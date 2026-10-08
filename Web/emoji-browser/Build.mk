# emoji-browser is a docker-compose Flask web challenge (compose lives in src/).
# `pwnmake check[Web/emoji-browser]` starts it, runs the solver, and tears it down.
$(call ctf_check_web,$(DIR),21301,emoji-browser.ctf.hackucf.org,python3 solver.py)
