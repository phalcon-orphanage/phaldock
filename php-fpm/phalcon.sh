#!/usr/bin/env bash

ORIG_PATH=$PATH

export ZEPHIRDIR=/usr/share/zephir
export PATH=$PATH:/usr/share/zephir/bin

mkdir -p $ZEPHIRDIR
mkdir -p /tmp/zephir
mkdir -p /tmp/phalcon

curl -L -o /tmp/zephir.tar.gz "https://github.com/phalcon/zephir/archive/0.9.3.tar.gz"
tar -C /tmp/zephir -zxvf /tmp/zephir.tar.gz --strip 1
cd /tmp/zephir

# because containers does not have sudo
echo "#!/usr/bin/env bash
exec \"\$@\"" > /usr/bin/sudo

chmod +x /usr/bin/sudo
(cd parser && phpize --clean)
./install -c
cd / && rm -rf /tmp/zephir

curl -L -o /tmp/phalcon-v2.1.x.tar.gz "https://github.com/phalcon/cphalcon/archive/2.1.x.tar.gz"
tar -C /tmp/phalcon -zxvf /tmp/phalcon-v2.1.x.tar.gz --strip 1
cd /tmp/phalcon
zephir build --backend=ZendEngine3
cp ext/modules/phalcon.so $(php-config --extension-dir)/phalcon.so

#echo 'extension=phalcon.so' | tee /etc/php5/mods-available/phalcon.ini

#ln -s /etc/php5/mods-available/phalcon.ini /etc/php5/conf.d/50-phalcon.ini

cd /
#rm -rf $ZEPHIRDIR /tmp/phalcon /usr/bin/sudo /tmp/zephir
export PATH=$ORIG_PATH
unset ZEPHIRDIR
unset ORIG_PATH
