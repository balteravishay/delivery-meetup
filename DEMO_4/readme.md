# High Level Definition

**Using Fabrikate to describe complex deliveries to multiple environments**

## Setup Fabrikate and generate common charts

``` sh
fab install

fab generate
```

## Add secondary environment

``` sh
fab set --environment qa-on-azure --subcomponent  efk.elasticsearch  volumeClaimTemplate.storageClass="managed-premium"

fab generate qa-on-azure
```

[Back](../readme.md)
