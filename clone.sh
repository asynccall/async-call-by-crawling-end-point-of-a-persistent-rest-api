if [ $(id -u) = 0 ]; then
   echo "This script must be run as normal user"
   exit 1
fi

cd /var/www/html/

git clone git@180.179.213.82:template_engine

cd template_engine/src/

mkdir minified_scripts

cd home_mini_finder

php minify_js_css.php

