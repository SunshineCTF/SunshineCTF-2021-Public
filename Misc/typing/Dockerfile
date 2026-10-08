# The "typing" challenge is a static site: index.html loads typing.ts, which is
# actually an MPEG transport-stream video (the ".ts" pun). Only these two files
# are served to players; solution material stays out of the image.
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
COPY typing.ts /usr/share/nginx/html/typing.ts
