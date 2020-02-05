

VERSION=${VERSION:=v1.4.9-hotfix.1}
CHANNEL=${CHANNEL:=beta}

baseurl=https://storage.googleapis.com/flutter_infra/releases/%s/%s/%s
echo $OSTYPE
if [[ $OSTYPE == "linux-gnu" ]]; then
    curl -O `printf $baseurl $CHANNEL linux flutter_linux_$VERSION-$CHANNEL.tar.xz`
    tar xf flutter_linux_$VERSION-$CHANNEL.tar.xz 
elif [[ $OSTYPE == "darwin" ]]; then
    curl -O `printf $baseurl $CHANNEL macos flutter_macos_$VERSION-$CHANNEL.zip`
    unzip flutter_macos_$VERSION-$CHANNEL.zip
else
    exit 1
fi

export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor