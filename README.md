# ![bento box](https://api.emojione.com/emoji/1f371/download/32) bentobox

A convenience layer for building bento-based Vagrant boxes

<!-- toc -->

- [Usage](#usage)
  * [local ISO](#local-iso)
  * [remote ISO](#remote-iso)
- [Configuration](#configuration)
- [License](#license)
- [Artwork](#artwork)

<!-- tocstop -->

## Usage

Basically you have two options:

### local ISO

Put the appropriate ISO in `${ISO_DIR}` and run:

```bash
BENTO_BOX_VERSION="9.4" bash build.sh
```

or:

```bash
BENTO_BOX_TYPE="centos" BENTO_BOX_VERSION="7.3" BENTO_BOX_ARCH="x86_64" bash build.sh
```

(this is useful for i.e. offline builds and/or not relying on packer's cache)

### remote ISO

Or just run the following, which will download the appropriate ISO automatically:

```bash
PACKER_OPTIONS="-only=parallels-iso" BENTO_BOX_VERSION="9.4" bash build.sh
```

or:

```bash
PACKER_OPTIONS="-only=parallels-iso" BENTO_BOX_TYPE="centos" BENTO_BOX_VERSION="7.3" BENTO_BOX_ARCH="x86_64" bash build.sh
```

## Configuration

The following configuration options exist and can be changed by injecting them
via the shell:

option | default
------ | -------
`BENTO_BOX_ARCH` | `amd64` 
`BENTO_BOX_NAME` | `${BENTO_BOX_PROVIDER}/${BENTO_BOX_TYPE}-${BENTO_BOX_VERSION}`
`BENTO_BOX_PROVIDER` | `parallels`
`BENTO_BOX_TYPE` | `debian` 
`BENTO_BOX_VERSION` | `9.5`
`BENTO_DIR` | `${HOME}/development/git/github/bento`
`BENTO_REPO` | `https://github.com/pari-/bento` 
`BENTO_REPO_BRANCH` | `local_mods`
`ISO_DIR` | `${HOME}/isos` 
`PACKER_DIR` | `${HOME}/Downloads/packer` 
`PACKER_DOWNLOAD_URL` | `https://releases.hashicorp.com/packer/${PACKER_VERSION}/${PACKER_DOWNLOAD_FILE}` 
`PACKER_DOWNLOAD_FILE` | `packer_${PACKER_VERSION}_darwin_amd64.zip`
`PACKER_VERSION` | `1.2.5`
`PACKER_OPTIONS` | `-var mirror=${ISO_DIR}/ -var mirror_directory= -only="{BENTO_BOX_PROVIDER}-iso`
`VAGRANT_BOX_DIR` | `${HOME}/config/vagrant_boxes` 

## License

MIT

## Artwork
* [bento box](https://api.emojione.com/emoji/1f371/download/32) Emoji artwork provided by [EmojiOne](https://www.emojione.com)
