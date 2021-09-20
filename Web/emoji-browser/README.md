# [Web 100] EmojiBrowser

A path traversal challenge with a lot of emoji.

This is created as a Flask app with the following public endpoints:

- `GET /`: The user interface.
- - `GET /index.css`: User styles.
- `GET /emoji/:emoji_codepoint`: The vulnerable file endpoint.

Please deploy to run uWSGI. Reverse proxies may mess with the path-traversal bit.

The following are worth noting:

- The flag can be set in `flag.txt`
- Install dependencies with `pip3 i -r requirements.txt`
- Please expose the directory this README lives in and everything in it, *including this file*. This challenge has a bit of a "meta" feel, as it pokes fun at last year's emoji challenges. Also, if they can read this file, they can read the flag.

## Solution

When you are on the home Web page, the player should notice that the image preview calls an external endpoint, `GET /emoji/:emoji_codepoint`. On trying an invalid URL on this endpoint, you will be shown a "default" emoji, `index.svg` in the given directory. This can be found in the file name when trying to download the emoji.

If a player tries to use a URL-encoded path traversal, they will notice that they get a normal 404 page; it renders a normal 404 page that is not related to the `/emoji/*` endpoint(s). However, if they double-URL-encode, they can begin to traverse paths, with an `index.svg` image to help them traverse the project directory. They can eventually find the flag file at the project's root directory:

```url
http://localhost:44077/emoji/..%252F..%252F..%252F
```

From here, the player needs to somehow bypass the `.svg` extension hard-code. This can be done by using null characters, as alluded in the JavaScript. The null sentinal will then end the string prematurely, allowing us to drop the `.svg` extension mandate.

```url
http://localhost:44077/emoji/..%252F..%252F..%252Fflag.txt%00
```