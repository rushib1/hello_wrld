# download gdrive
echo 'downloading gdrive'
if [[ $OSTYPE == "linux-gnu" ]]; then
    curl -LJ https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-linux-x64 -o gdrive
elif [[ $OSTYPE == "darwin" ]]; then
    curl -LJ https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-osx-x64 -o gdrive
fi

chmod 777 gdrive

mkdir $HOME/.gdrive
cp scripts/serviceaccount.json $HOME/.gdrive/serviceaccount.json 
./gdrive upload scripts --service-account serviceaccount.json --recursive