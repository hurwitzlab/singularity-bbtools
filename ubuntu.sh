BootStrap: debootstrap
OSVersion: trusty
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%environment
    PATH="/usr/bin/bbmap:$PATH"

%runscript
    echo -e "This runs bbmap.sh by default\nDo exec [img] ls /usr/bin/bbmap to find list
    of other programs"
    exec /usr/bin/bbmap/bbmap.sh "$@"

%post
    echo "Hello from inside the container"
    sed -i 's/$/ universe/' /etc/apt/sources.list

    #essential stuff
    apt -y --force-yes install git sudo man vim build-essential wget unzip

    touch /etc/init.d/systemd-logind
    sudo apt -y --force-yes install default-jre
    
    #maybe dont need, add later if do:
    #curl autoconf libtool 
    
    mkdir /apps
    cd /apps
    wget --no-check-certificate https://astuteinternet.dl.sourceforge.net/project/bbmap/BBMap_37.55.tar.gz -O bbmap.tar.gz
    sudo tar -xzf bbmap.tar.gz
    sudo ln -s /apps/bbmap /usr/bin/bbmap

    rm bbmap.tar.gz

    #so we dont get those stupid perl warnings
    locale-gen en_US.UTF-8

    #so we dont get those stupid worning on hpc/pbs
    mkdir /extra
    mkdir /xdisk
    mkdir /rsgrps
    mkdir -p /cm/shared
