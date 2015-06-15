#!/bin/bash

FCREPO=http://localhost:8080/fcrepo/rest

# Clear out existing resources
curl -X DELETE $FCREPO/objects/
curl -X DELETE $FCREPO/objects/fcr:tombstone
curl -X DELETE $FCREPO/collections/
curl -X DELETE $FCREPO/collections/fcr:tombstone

# The Book

# Create DirectContainer
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @pcdm-object.ttl $FCREPO/objects/
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @pcdm-object.ttl $FCREPO/objects/raven/
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @ldp-direct.ttl  $FCREPO/objects/raven/pages/

# Create cover, page0 and page1
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @pcdm-object.ttl $FCREPO/objects/raven/pages/cover/
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @pcdm-object.ttl $FCREPO/objects/raven/pages/page0/
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @pcdm-object.ttl $FCREPO/objects/raven/pages/page1/

# Cover container and files
curl -i -X PUT   -H "Content-Type: text/turtle"               --data-binary @ldp-cover-direct.ttl $FCREPO/objects/raven/pages/cover/files/
curl -i -X PUT   -H "Content-Type: image/jpeg"                --data-binary @cover.jpg            $FCREPO/objects/raven/pages/cover/files/cover.jpg
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @pcdm-file.ru         $FCREPO/objects/raven/pages/cover/files/cover.jpg/fcr:metadata
curl -i -X PUT   -H "Content-Type: image/tiff"                --data-binary @cover.tif            $FCREPO/objects/raven/pages/cover/files/cover.tif
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @pcdm-file.ru         $FCREPO/objects/raven/pages/cover/files/cover.tif/fcr:metadata

# Page0 container and files
curl -i -X PUT -H   "Content-Type: text/turtle"               --data-binary @ldp-page0-direct.ttl $FCREPO/objects/raven/pages/page0/files/
curl -i -X PUT -H   "Content-Type: image/jpeg"                --data-binary @page0.jpg            $FCREPO/objects/raven/pages/page0/files/page0.jpg
curl -i -X PUT -H   "Content-Type: image/tiff"                --data-binary @page0.tif            $FCREPO/objects/raven/pages/page0/files/page0.tif
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @pcdm-file.ru         $FCREPO/objects/raven/pages/page0/files/page0.jpg/fcr:metadata
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @pcdm-file.ru         $FCREPO/objects/raven/pages/page0/files/page0.tif/fcr:metadata

# Page1 container and files
curl -i -X PUT -H   "Content-Type: text/turtle"               --data-binary @ldp-page1-direct.ttl $FCREPO/objects/raven/pages/page1/files/
curl -i -X PUT -H   "Content-Type: image/jpeg"                --data-binary @page1.jpg            $FCREPO/objects/raven/pages/page1/files/page1.jpg
curl -i -X PUT -H   "Content-Type: image/tiff"                --data-binary @page1.tif            $FCREPO/objects/raven/pages/page1/files/page1.tif
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @pcdm-file.ru         $FCREPO/objects/raven/pages/page1/files/page1.jpg/fcr:metadata
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @pcdm-file.ru         $FCREPO/objects/raven/pages/page1/files/page1.tif/fcr:metadata

# The collection

curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @pcdm-object.ttl      $FCREPO/collections/
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @pcdm-object.ttl      $FCREPO/collections/poe/
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @ldp-indirect.ttl     $FCREPO/collections/poe/members/
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @pcdm-raven-proxy.ttl $FCREPO/collections/poe/members/ravenProxy

# Proxies for ordering

curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @ldp-ordering-direct.ttl $FCREPO/objects/raven/orderProxies/
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @ldp-cover-proxy.ttl     $FCREPO/objects/raven/orderProxies/coverProxy
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @ldp-page0-proxy.ttl     $FCREPO/objects/raven/orderProxies/page0Proxy
curl -i -X PUT -H "Content-Type: text/turtle" --data-binary @ldp-page1-proxy.ttl     $FCREPO/objects/raven/orderProxies/page1Proxy

# And the actual order
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @iana-cover-proxy.ru $FCREPO/objects/raven/orderProxies/coverProxy
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @iana-page0-proxy.ru $FCREPO/objects/raven/orderProxies/page0Proxy
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @iana-page1-proxy.ru $FCREPO/objects/raven/orderProxies/page1Proxy
curl -i -X PATCH -H "Content-Type: application/sparql-update" --data-binary @iana-raven.ru       $FCREPO/objects/raven/


