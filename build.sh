#!/bin/bash

BENTO_BOX_ARCH=${BENTO_BOX_ARCH:-"amd64"}
BENTO_BOX_TYPE=${BENTO_BOX_TYPE:-"debian"}
BENTO_BOX_PROVIDER=${BENTO_BOX_PROVIDER:-"parallels"}
BENTO_BOX_VERSION=${BENTO_BOX_VERSION:-"9.3"}
BENTO_BOX_NAME=${BENTO_BOX_NAME:-"${BENTO_BOX_PROVIDER}/${BENTO_BOX_TYPE}-${BENTO_BOX_VERSION}"}
BENTO_DIR=${BENTO_DIR:-"${HOME}/development/bento"}
BENTO_REPO=${BENTO_REPO:-"https://github.com/pari-/bento"}
BENTO_REPO_BRANCH=${BENTO_REPO_BRANCH:-"local_mods"}
ISO_DIR=${ISO_DIR:-"${HOME}/isos"}
PACKER_DIR=${PACKER_DIR:-"${HOME}/Downloads/packer"}
PACKER_VERSION=${PACKER_VERSION:-"1.2.2"}
PACKER_DOWNLOAD_FILE=${PACKER_DOWNLOAD_FILE:-"packer_${PACKER_VERSION}_darwin_amd64.zip"}
PACKER_DOWNLOAD_URL=${PACKER_DOWNLOAD_URL:-"https://releases.hashicorp.com/packer/${PACKER_VERSION}"}
PACKER_OPTIONS=${PACKER_OPTIONS:-"-var mirror=${ISO_DIR}/ -var mirror_directory= -only=${BENTO_BOX_PROVIDER}-iso"}
VAGRANT_BOX_DIR=${VAGRANT_BOX_DIR:-"${HOME}/config/vagrant_boxes"}

#
# create PACKER_DIR
#
mkdir -p "${PACKER_DIR}/${PACKER_VERSION}"

#
# retrieve, unpack and cleanup PACKER_VERSION
#
if [ ! -f "${PACKER_DIR}/${PACKER_VERSION}/packer" ];
then
	wget -O "${PACKER_DIR}/${PACKER_VERSION}/${PACKER_DOWNLOAD_FILE}" "${PACKER_DOWNLOAD_URL}/${PACKER_DOWNLOAD_FILE}"
	unzip "${PACKER_DIR}/${PACKER_VERSION}/${PACKER_DOWNLOAD_FILE}" -d "${PACKER_DIR}/${PACKER_VERSION}/"
	rm "${PACKER_DIR}/${PACKER_VERSION}/${PACKER_DOWNLOAD_FILE}"
fi

#
# setup my bento repo
#
if [ ! -d "${BENTO_DIR}" ];
then
	git clone "${BENTO_REPO}" "${BENTO_DIR}"
	cd "${BENTO_DIR}" && git checkout "${BENTO_REPO_BRANCH}"
fi

#
# build the vagrant box
#
cd "${BENTO_DIR}/${BENTO_BOX_TYPE}" && "${PACKER_DIR}/${PACKER_VERSION}/packer" build ${PACKER_OPTIONS} "${BENTO_BOX_TYPE}-${BENTO_BOX_VERSION}-${BENTO_BOX_ARCH}.json"

#
# setup the VAGRANT_BOX_DIR
#
mkdir -p "{VAGRANT_BOX_DIR}"

#
# move the built box to VAGRANT_BOX_DIR
#
mv "${BENTO_DIR}/builds/${BENTO_BOX_TYPE}-${BENTO_BOX_VERSION}.${BENTO_BOX_PROVIDER}.box" "${VAGRANT_BOX_DIR}"

#
# add the built vagrant box
#
vagrant box add "${VAGRANT_BOX_DIR}/${BENTO_BOX_TYPE}-${BENTO_BOX_VERSION}.${BENTO_BOX_PROVIDER}.box" --name "${BENTO_BOX_NAME}"
