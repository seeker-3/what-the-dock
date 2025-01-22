# What the Dock

OMZ installer for dockerfiles.

## Usage

Basic usage:

```bash
bash -c "$(curl -fsSL https://raw.github.com/seeker-3/what-the-dock/main/install.bash)"
```

By default comes with:

- `tamcore/autoupdate-oh-my-zsh-plugins`
- `zsh-users/zsh-autosuggestions`
- `zsh-users/zsh-syntax-highlighting`

With additional plugins:

```bash
bash -c "$(curl -fsSL https://raw.github.com/seeker-3/what-the-dock/main/install.bash)" -- hlissner/zsh-autopair
```

Full example:

```dockerfile
FROM ubuntu:latest

ENV LANG=C.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=C.UTF-8

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install curl

RUN bash -c "$(curl -fsSL https://raw.github.com/seeker-3/what-the-dock/main/install.bash)"

# ...

RUN apt-get autoremove
RUN apt-get clean
RUN apt-get autoclean
RUN apt-get -f install
```

## Caveats

Currently only supports `apt-get` but more could be added in the future.
