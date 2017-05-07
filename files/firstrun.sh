#!/bin/bash

chown -R $USER_ID.$GROUP_ID /opt/atom

mkdir -p /.atom
ln -s /.atom /nobody/.atom 
chown -R $USER_ID.$GROUP_ID /.atom

ln -s /workspace /nobody/workspace

setopt shwordsplit
for package in $APM_PACKAGES; do
  su nobody -c "apm install $package"
done
root@6448a0eefa3e:/etc/my_init.d# cat firstrun.sh 
#!/bin/bash

chown -R $USER_ID.$GROUP_ID /opt/atom

mkdir -p /.atom
ln -s /.atom /nobody/.atom 
chown -R $USER_ID.$GROUP_ID /.atom

ln -s /workspace /nobody/workspace

setopt shwordsplit
for package in $APM_PACKAGES; do
  su nobody -c "apm install $package"
done
