# Solr configuration

Whenever Arclight is installed or rebuilt, the existing Solr config files will be replaced with the latest from blacklight-marc.

Any persistent changes required to the Arclight Solr configuration must be made in the [solr-trove](https://github.com/nla/solr-trove/tree/master/solr-config/src/main/resources/arclight) repo.

Prior to deploying a standalone Solr server (e.g. for local testing), copy any required Blacklight Solr config files from the [solr-trove](https://github.com/nla/solr-trove/tree/master/solr-config/src/main/resources/arclight) repo.
