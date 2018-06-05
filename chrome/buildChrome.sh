# build headless chrome on sbox
# https://github.com/adieuadieu/serverless-chrome/blob/master/chrome/README.md

# sudo su

apt-get install flex bison libcogl-pango-dev

cd ~
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
echo "export PATH=$PATH:$HOME/depot_tools" >> ~/.bash_profile
source ~/.bash_profile

mkdir Chromium
cd Chromium
fetch --no-history chromium
cd src

# use /tmp instead of /dev/shm
# https://groups.google.com/a/chromium.org/forum/#!msg/headless-dev/qqbZVZ2IwEw/CPInd55OBgAJ
sed -i -e "s/use_dev_shm = true;/use_dev_shm = false;/g" base/files/file_util_posix.cc

mkdir -p out/Headless
echo 'import("//build/args/headless.gn")' > out/Headless/args.gn
echo 'is_debug = false' >> out/Headless/args.gn
echo 'symbol_level = 0' >> out/Headless/args.gn
echo 'is_component_build = false' >> out/Headless/args.gn
echo 'remove_webcore_debug_symbols = true' >> out/Headless/args.gn
echo 'enable_nacl = false' >> out/Headless/args.gn
gn gen out/Headless
ninja -C out/Headless headless_shell

cd out/Headless
tar -zcvf /home/ec2-user/headless_shell.tar.gz headless_shell 

# scp ec2-user@xxx.amazonaws.com:~/headless_shell.tar.gz .
