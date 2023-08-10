#!/bin/sh -eu

if [ -n "${CI+}" ]
then
	set -x
	export PS4='(${0}:${LINENO}): - [$?] $ '
fi

if [ "$#" -ne 1 ]
then
	echo "Usage: $0 domjudge-version"
	echo "	For example: $0 5.3.0"
	exit 1
fi

VERSION="$1"
DOMSERVER="$2"
JUDGEHOST="$3"
CHROOT="$4"

URL=https://www.domjudge.org/releases/domjudge-${VERSION}.tar.gz
FILE=domjudge.tar.gz

echo "[..] Downloading DOMjudge version ${VERSION}..."

#if ! wget --quiet "${URL}" -O ${FILE}
#then
#	echo "[!!] DOMjudge version ${VERSION} file not found on https://www.domjudge.org/releases"
#	exit 1
#fi

echo "[ok] DOMjudge version ${VERSION} downloaded as domjudge.tar.gz"; echo

if [ "$DOMSERVER" = "domserver"]; then
#echo "[..] Building Docker image for domserver..."
#./build-domjudge-alpine.sh "mvr320/domserver-alpine:${VERSION}"
#echo "[ok] Done building Docker image for domserver"
#docker push mvr320/domserver:${VERSION}
#docker tag mvr320/domserver:${VERSION} domjudge/domserver:latest
#docker push mvr320/domserver:latest
fi

if [ "$JUDGEHOST" = "judgehost"]; then
#echo "[..] Building Docker image for judgehost using intermediate build image..."
#./build-judgehost.sh "mvr320/judgehost:${VERSION}"
#./build-judgehost-alpine.sh "mvr320/judgehost-alpine:${VERSION}"
#echo "[ok] Done building Docker image for judgehost"
#docker push mvr320/judgehost:${VERSION}
#docker tag mvr320/judgehost:${VERSION} domjudge/judgehost:latest
#docker push mvr320/judgehost:latest
fi

if [ "$CHROOT" = "chroot"]; then
#echo "[..] Building Docker image for judgehost chroot..."
#docker build -t "mvr320/default-judgehost-chroot:${VERSION}" -f judgehost/Dockerfile.chroot .
#docker build -t "mvr320/default-judgehost-chroot-alpine:${VERSION}" -f judgehost/Dockerfile.chroot-alpine .
#echo "[ok] Done building Docker image for judgehost chroot"
docker push mvr320/default-judgehost-chroot:${VERSION}
#docker tag mvr320/default-judgehost-chroot:${VERSION} mvr320/default-judgehost-chroot:latest
#docker push mvr320/default-judgehost-chroot:latest"
fi

if [ "$DOMSERVER" = "domserver"]; then
if [ "$JUDGEHOST" = "judgehost"]; then
if [ "$CHROOT" = "chroot"]; then
echo "All done. Image domjudge/domserver:${VERSION} and domjudge/judgehost:${VERSION} created"
fi
fi
fi
