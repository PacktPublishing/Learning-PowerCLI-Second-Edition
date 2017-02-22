Connect-VIServer -Server vcsa-01a.corp.local
$NSXManager = '192.168.110.15'
$Username = 'admin'
$Password = 'VMware1!'
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$Username`:$Password"))
$Headers = @{Authorization = "Basic $base64AuthInfo"}
$Body = @'
<edge>
  <datacenterMoid>datacenter-21</datacenterMoid>
  <datacenterName>RegionA01</datacenterName>
  <tenant>default</tenant>
  <name>Distributed-Router-02</name>
  <fqdn>vShield-edge-2</fqdn>
  <enableAesni>true</enableAesni>
  <enableFips>false</enableFips>
  <vseLogLevel>emergency</vseLogLevel>
  <vnics>
    <vnic>
      <label>vNic_0</label>
      <name>pk</name>
      <addressGroups>
        <addressGroup>
          <primaryAddress>10.112.203.19</primaryAddress>
          <subnetMask>255.255.255.0</subnetMask>
          <subnetPrefixLength>24</subnetPrefixLength>
        </addressGroup>
      </addressGroups>
      <mtu>1500</mtu>
      <type>uplink</type>
      <isConnected>true</isConnected>
      <index>0</index>
      <portgroupId>network-12</portgroupId>
      <portgroupName>VM Network</portgroupName>
      <enableProxyArp>false</enableProxyArp>
      <enableSendRedirects>false</enableSendRedirects>
    </vnic>
    <vnic>
      <label>vNic_1</label>
      <name>vnic1</name>
      <addressGroups />
      <mtu>1600</mtu>
      <type>trunk</type>
      <subInterfaces>
        <subInterface>
          <isConnected>true</isConnected>
          <label>vNic_10</label>
          <name>Two</name>
          <index>10</index>
          <tunnelId>100</tunnelId>
          <vlanId>100</vlanId>
          <enableSendRedirects>false</enableSendRedirects>
          <mtu>1500</mtu>
          <addressGroups>
            <addressGroup>
              <primaryAddress>10.10.10.1</primaryAddress>
              <subnetMask>255.255.255.0</subnetMask>
              <subnetPrefixLength>24</subnetPrefixLength>
            </addressGroup>
          </addressGroups>
        </subInterface>
      </subInterfaces>
      <isConnected>true</isConnected>
      <index>1</index>
      <portgroupId>dvportgroup-37</portgroupId>
      <portgroupName>dvPortGroup2</portgroupName>
      <enableProxyArp>false</enableProxyArp>
      <enableSendRedirects>false</enableSendRedirects>
    </vnic>
  </vnics>
  <appliances>
    <deployAppliances>false</deployAppliances>
  </appliances>
  <cliSettings>
    <remoteAccess>true</remoteAccess>
    <userName>admin</userName>
    <password>Applenumber@143</password>
  </cliSettings>
  <autoConfiguration>
    <enabled>true</enabled>
    <rulePriority>high</rulePriority>
  </autoConfiguration>
  <type>distributedRouter</type>
  <isUniversal>false</isUniversal>
  <hypervisorAssist>false</hypervisorAssist>
  <queryDaemon>
    <enabled>false</enabled>
    <port>5666</port>
  </queryDaemon>
</edge>
'@

$Uri = "https://$NSXManager/api/4.0/edges"
Invoke-RestMethod -Uri $Uri -Method Post -Body $Body -ContentType 'application/xml' -Headers $Headers