#!/bin/bash
set -e

while [ -n "$(ls /usr/local/tomcat/webapps/geonetwork/WEB-INF/data/config/schema_plugins/iso19139/layout/ 2>&1 > /dev/null)" ]; do
  echo "waiting for GN data dir to be filled..."
  sleep 1
done

echo "GN data dir is ready"

if [ ! -f /usr/local/tomcat/webapps/geonetwork/WEB-INF/data/inspire ]; then

#enable inspire view
sed -i -e 's#<view name="inspire" upAndDownControlHidden="true" disabled="true">#<view name="inspire" upAndDownControlHidden="true">#g' \
/usr/local/tomcat/webapps/geonetwork/WEB-INF/data/config/schema_plugins/iso19139/layout/config-editor.xml

#enable schematron files
files=/usr/local/tomcat/webapps/geonetwork/WEB-INF/data/config/schema_plugins/iso19139/schematron/*inspire*disabled.*
if ls $files 1> /dev/null 2>&1; then
  for file in $files; do
    echo "renaming $file"
    mv "$file" "${file/disabled./}"
  done
else
  echo "files renamed; doing nothing"
fi


#download inspire themes
wget -P /usr/local/tomcat/webapps/geonetwork/WEB-INF/data/config/codelist/local/thesauri/theme/ https://raw.githubusercontent.com/geonetwork/util-gemet/master/thesauri/inspire-theme.rdf
wget -P /usr/local/tomcat/webapps/geonetwork/WEB-INF/data/config/codelist/local/thesauri/theme/ https://github.com/geonetwork/util-gemet/raw/master/thesauri/gemet.rdf
wget -P /usr/local/tomcat/webapps/geonetwork/WEB-INF/data/config/codelist/local/thesauri/theme/ https://raw.githubusercontent.com/geonetwork/util-gemet/master/thesauri/inspire-service-taxonomy.rdf
echo "Inspire GN is ready!"
echo "Inspire GN is ready!" > /usr/local/tomcat/webapps/geonetwork/WEB-INF/data/inspire

else
echo "Inspire already setup!"
fi

exec "$@"

