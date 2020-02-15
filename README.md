git-get
---

A simple script to handle github pull requests.


### Installation:

- Clone this repo:

```sh
git clone https://github.com/julien/git-get.git
```

- As long as the `git-get` script is in your `$PATH`, you'll be able to
invoke `git get` inside a `.git` repository

### Usage:

```sh
git get COMMAND

Available commands:

fetch NUMBER           Fetch pull request NUMBER
ls                     List pull requests
patches                Download patches
send [USER][BRANCH]    Open URL to create a pull request
```

### Limitations:

Only works for github projects

Another one here
