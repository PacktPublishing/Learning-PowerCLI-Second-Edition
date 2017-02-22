$vRAServer = 'vra-01a.corp.local'
$Username = 'cloudadmin@corp.local'
$Password = 'VMware1!'
$Tenant = 'vsphere.local'
$Body = @"
{
  "username":"$Username",
  "password":"$Password",
  "tenant":"$Tenant"
}
"@

$Uri = "https://$vRAServer/identity/api/tokens"
$Response = Invoke-RestMethod -Uri $Uri -Method POST -Body $Body -ContentType 'application/json'
$DefaultvRAServer = [pscustomobject]@{
  Server = $vRAServer
  Token = $Response.id
  Expires = $Response.Expires 
  Tenant = $Response.tenant
  Username = $Username
}

$Headers = @{
  Accept = "application/json"
  'Content-Type' = "application/json"
  Authorization = "Bearer $($Global:DefaultvRAServer.Token)"
}

$Body = @"
{
  "name": "Reservation for Business Group Development",
  "reservationTypeId": "Infrastructure.Reservation.Virtual.vSphere",
  "tenantId": "vsphere.local",
  "subTenantId": "197166cd-bd9c-4d55-b474-1d8e53127843",
  "enabled": true,
  "priority": 2,
  "reservationPolicyId": null,
  "alertPolicy": {
    "enabled": true,
    "frequencyReminder": 20,
    "emailBgMgr": true,
    "recipients": null,
    "alerts": [{
      "alertPercentLevel": 10,
      "referenceResourceId": "storage",
      "id": "storage"
    },
    {
      "alertPercentLevel": 20,
      "referenceResourceId": "memory",
      "id": "memory"
    },
    {
      "alertPercentLevel": 30,
      "referenceResourceId": "cpu",
      "id": "cpu"
    },
    {
      "alertPercentLevel": 40,
      "referenceResourceId": "machine",
      "id": "machine"
    }]
  },
  "extensionData": {
    "entries": [{
      "key": "reservationNetworks",
      "value": {
        "type": "multiple",
        "elementTypeId": "COMPLEX",
        "items": [{
          "type": "complex",
          "componentTypeId": "com.vmware.csp.iaas.blueprint.service",
          "componentId": null,
          "classId": "reservationNetwork",
          "typeFilter": null,
          "values": {
            "entries": [{
              "key": "reservationNetworkPath",
              "value": {
                "type": "entityRef",
                "componentId": null,
                "classId": "Network",
                "id": "72be8c3c-e868-4888-880d-10e15b9206ad",
                "label": "VM-RegionA01-vDS-COMP"
              }
            }]
          }
        }]
      }
    },
    {
      "key": "custom-Properties-key0",
      "value": {
        "type": "string",
        "value": "custom-property-value0"
      }
    },
    {
      "key": "custom-Properties-key2",
      "value": {
        "type": "string",
        "value": "custom-property-value2"
      }
    },
    {
      "key": "reservationMemory",
      "value": {
        "type": "complex",
        "componentTypeId": "com.vmware.csp.iaas.blueprint.service",
        "componentId": null,
        "classId": "reservationMemory",
        "typeFilter": null,
        "values": {
          "entries": [{
            "key": "hostMemoryTotalSizeMB",
            "value": {
              "type": "integer",
              "value": 57187
            }
          },
          {
            "key": "memoryReservedSizeMb",
            "value": {
              "type": "integer",
              "value": 15872
            }
          }]
        }
      }
    },
    {
      "key": "computeResource",
      "value": {
        "type": "entityRef",
        "componentId": null,
        "classId": "ComputeResource",
        "id": "74db440b-3d12-4cee-bdd2-f9ae10b5746d",
        "label": "RegionA01-COMP01 (vCenter)"
      }
    },
    {
      "key": "machineQuota",
      "value": {
        "type": "integer",
        "value": 2
      }
    },
    {
      "key": "reservationStorages",
      "value": {
        "type": "multiple",
        "elementTypeId": "COMPLEX",
        "items": [{
          "type": "complex",
          "componentTypeId": "com.vmware.csp.iaas.blueprint.service",
          "componentId": null,
          "classId": "reservationStorage",
          "typeFilter": null,
          "values": {
            "entries": [{
              "key": "storageTotalSizeGB",
              "value": {
                "type": "integer",
                "value": 394
              }
            },
            {
              "key": "storageReservedSizeGB",
              "value": {
                "type": "integer",
                "value": 32
              }
            },
            {
              "key": "storageReservationPriority",
              "value": {
                "type": "integer",
                "value": 1
              }
            },
            {
              "key": "storageEnabled",
              "value": {
                "type": "boolean",
                "value": true
              }
            },
            {
              "key": "storagePath",
              "value": {
                "type": "entityRef",
                "componentId": null,
                "classId": "storagePath",
                "id": "1c9e1849-d841-4b22-a7bd-2199133119c0",
                "label": "RegionA01-ISCSI01-COMP01"
              }
            },
            {
              "key": "storageFreeSizeGB",
              "value": {
                "type": "integer",
                "value": 120
              }
            },
            {
              "key": "storagePriority",
              "value": {
                "type": "integer",
                "value": 1
              }
            }]
          }
        }]
      }
    },
    {
      "key": "reservationNetworks",
      "value": {
        "type": "multiple",
        "elementTypeId": "COMPLEX",
        "items": [{
          "type": "complex",
          "componentTypeId": "com.vmware.csp.iaas.blueprint.service",
          "componentId": null,
          "classId": "Infrastructure.Reservation.network",
          "typeFilter": null,
          "values": {
            "entries": [{
              "key": "networkPath",
              "value": {
                "type": "entityRef",
                "componentId": null,
                "classId": "Network",
                "id": "72be8c3c-e868-4888-880d-10e15b9206ad",
                "label": "VM-RegionA01-vDS-COMP"
              }
            },
            {
              "key": "networkProfile",
              "value": {
                "type": "entityRef",
                "componentId": null,
                "classId": "networkProfile",
                "id": "056cbcde-0d65-4ed3-88b8-1ab8db060c14",
                "label": "External Default Network"
              }
            }]
          }
        }]
      }
    }]
  }
}
"@

$Uri = "https://$vRAServer/reservation-service/api/reservations"
Invoke-RestMethod -Uri $Uri -Method POST -Body $Body -Headers $Headers