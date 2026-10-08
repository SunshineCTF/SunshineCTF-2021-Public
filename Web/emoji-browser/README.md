# [Web] EmojiBrowser

A web challenge with a lot of emoji.

This is created as a Flask app with the following public endpoints:

- `GET /`: The user interface.
- - `GET /index.css`: User styles.
- `GET /emoji/:emoji_codepoint`: Serves emoji images.

Please deploy to run uWSGI. Reverse proxies may mess with the intended solve (see the writeup).

The following are worth noting:

- The flag can be set in `flag.txt`
- Install dependencies with `pip3 i -r requirements.txt`
- Please expose the directory this README lives in and everything in it, *including this file*. This challenge has a bit of a "meta" feel, as it pokes fun at last year's emoji challenges.

See [writeup.md](writeup.md) for the solution.
