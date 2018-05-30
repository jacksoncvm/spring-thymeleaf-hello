#!/usr/bin/env bash

cf target -o pivotal -s www-prod


./gradlew clean build


curl_results=$(curl springone.cfapps.io)

if [[ $curl_results == *springone.cfapps.io* ]]
then
  cf push springone
  read -p "Test http://springone.cfapps.io, then press [Enter] key to continue mapping springone2gx.com route..."
  cf map-route springone springone2gx.com
  cf map-route springone springone2gx.com -n www
  cf unmap-route springone2 springone2gx.com
  cf unmap-route springone2 springone2gx.com -n www
  cf stop springone2
else
  cf push springone2
  read -p "Test http://springone2.cfapps.io, then press [Enter] key to continue mapping springone2gx.com route..."
  cf map-route springone2 springone2gx.com
  cf map-route springone2 springone2gx.com -n www
  cf unmap-route springone springone2gx.com
  cf unmap-route springone springone2gx.com -n www
  cf stop springone
fi



