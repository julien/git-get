git-get
---

A simple script to handle GitHub pull requests.

### Why?

There are lots of tools built around git and GitHub. They're all pretty and have
a plethora of features, but I just care about a few things:

- Listing pull requests
- Fetching a pull request branch
- Getting the patches for a pull request
- Sending a PR

These are trivial operations that can all be done with git
and a browser but automating them can save time. I also didn't
want to depend on anything else than a shell script and git
to do all of this, which explains why the "code" is what it is.

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

### Alternatives:

If you just care about fetching pull requests, you can add this alias in
your `.gitconfig`

```gitconfig
[alias]
	# ... your stuff

	# fetch a pr from github: git gh REMOTE NUMBER
	# (i.e. git gh origin 42)
	gh = "!f() {  git fetch --update-head-ok $1 +\"pull/$2/head:pull/$2\";  }; f"
```

Obviously, this is more limited but it works

### Limitations:

Only works for GitHub projects
