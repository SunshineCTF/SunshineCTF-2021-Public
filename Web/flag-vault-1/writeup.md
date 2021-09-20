# Flag Vault 1 Writeup

This is a two-phase challenge which is targetted to engage users in a medium difficulty of reverse engineering and an easier web challenge.

## Phase 1: Reverse Engineering Authentication

When the user visits the site for the first time, they are presented with a number of links. The first set of links that is important is the login page (`/login`) and the binary download (`/download`). The user does not know the proper credential, but they are provided the Golang binary used to run the site. 

In this binary, the user can find a hardcoded credential is in use by the program. This can be found by looking at the login function and the strings referenced by this login function.

From this, the user is able to login to `/login` and receives a JWT. When attempting to view `/flag` now, the user is told they don't have access. If they decode their jwt, they find the follwowing data:

```json
{
  "name": "pope",
  "flag_viewer": false,
  "exp": 1630563892,
  "iss": "The Holy See"
}
```

If they continue to reverse the binary, they can also find that the static key to sign these JWTs is included. If they extract the static JWT signing key, edit `flag_viewer` to be `true`, then sign the JWT using that key, they will be able to view the flag.