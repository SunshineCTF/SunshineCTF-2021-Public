# EmojiBrowser Writeup

A path traversal challenge with a lot of emoji. `GET /emoji/:emoji_codepoint` is the vulnerable file endpoint. Reverse proxies may mess with the path-traversal bit, and the challenge directory (including the README) is exposed because if players can read the README, they can read the flag.

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
