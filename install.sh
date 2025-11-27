#/bin/bash

# configFiles=$(ls -p configFiles/)
configFiles=$(ls configFiles/)
bakDir=old.conf
confDir=configFiles

function __do_backup__()
{
    backDirFullPath=$(pwd)/$bakDir
    if [ ! -d $backDirFullPath ]
    then 
        echo Le répertoire $backDirFullPath n\'existe pas... 
        echo Création de $backDirFullPath...
        mkdir -p $backDirFullPath
    fi
    for f in $configFiles
    do
        echo -e "\t - cp -rf $HOME/.$f $backDirFullPath"
        cp -rf $HOME/.$f $backDirFullPath 2> /dev/null
    done
}

function __do_install__()
{
    for f in $configFiles
    do 
        file=$(pwd)/$confDir/$f 
        home=$HOME/.$f 
        echo -e "\t - ln -sf $file $home "
        ln -sf $file $home
    done
}

echo "Ce script ecrasera les fichiers de configurations suivant :"

for f in $configFiles
do 
    echo -e "\t - $HOME/.$f"
done

echo "Une copie des anciens fichiers de configuration sera effectuée dans le répertoire $(pwd)/$bakDir."

read -p "Voulez vous continuer ? O/n : " continue
if [[ $continue != "O" && $continue != "o" ]]
then
    echo abort
else
    echo "Copie des anciens fichiers de configuration dans $(pwd)/$bakDir..."
    __do_backup__
    echo "Installation des nouveaux fichiers de configurations dans $HOME..."
    __do_install__
    echo "Installation terminée."
fi

