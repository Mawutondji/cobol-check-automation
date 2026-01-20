4s
Run set -euxo pipefail
+ chmod +x .github/scripts/zowe_operations.sh
+ .github/scripts/zowe_operations.sh
+ command -v zowe
++ echo ***
++ tr '[:upper:]' '[:lower:]'
+ LOWERCASE_USERNAME=z60636
+ timeout 60s zowe zosmf check status --zosmf-profile zprofile
The user *** successfully connected to z/OSMF on 'S0W1.DAL-EBIS.IHOST.COM'.
zosmf_port:         ***
zosmf_saf_realm:    SAFRealm
zos_version:        05.29.00
zosmf_full_version: 29.0
api_version:        1

z/OSMF Plug-ins that are installed on 'S0W1.DAL-EBIS.IHOST.COM':
- 
  pluginVersion:     HSMA310;PH67697;2025-08-27T17:00:53
  pluginDefaultName: z/OS Operator Consoles
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA310;DRIVER5;2023-03-15T10:28:59
  pluginDefaultName: Variables
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA314;PH67755P;2025-11-18T19:46:28
  pluginDefaultName: Software Deployment
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA317;PH68481;2025-11-14T20:51:23
  pluginDefaultName: Workflow
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA315;PH64564;2025-03-01T12:05:35
  pluginDefaultName: IncidentLog
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA31A;PH68655;2025-10-29T09:09:07
  pluginDefaultName: Network Configuration Assistant
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA31E;PH65586;2025-06-09T03:34:03
  pluginDefaultName: IBM zERT Network Analyzer
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA311;PH67365;2025-07-22T18:06:48
  pluginDefaultName: ISPF
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA310;DRIVER5;2023-03-15T10:26:24
  pluginDefaultName: Import Manager
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA312;PH66143;2025-09-12T12:37:04
  pluginDefaultName: ResourceMonitoring
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA310;DRIVER4;2022-11-13T20:15:03
  pluginDefaultName: z/OS Management Services Catalog
  pluginStatus:      INSTALLED
- 
  pluginVersion:     HSMA313;PH65576;2025-04-07T17:16:18
  pluginDefaultName: WorkloadManagement
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA316;PH67654;2025-09-22T12:18:15
  pluginDefaultName: Capacity Provisioning
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA310;PH61589;2024-06-20T06:32:42
  pluginDefaultName: Security Configuration Assistant
  pluginStatus:      ACTIVE
- 
  pluginVersion:     HSMA310;PH58228;2023-11-20T19:56:54
  pluginDefaultName: Cloud Provisioning
  pluginStatus:      ACTIVE


+ timeout 60s zowe zos-files list uss-files /z/z60636/cobolcheck --zosmf-profile zprofile
+ echo 'Directory already exists.'
Directory already exists.
++ find ./cobol-check/bin -maxdepth 1 -name '*.jar'
++ head -n 1
+ JAR_PATH=./cobol-check/bin/cobol-check-0.2.19.jar
+ '[' -z ./cobol-check/bin/cobol-check-0.2.19.jar ']'
+ JAR_RELATIVE_PATH=bin/cobol-check-0.2.19.jar
+ timeout 300s zowe zos-files upload dir-to-uss ./cobol-check /z/z60636/cobolcheck --recursive --zosmf-profile zprofile --binary-files bin/cobol-check-0.2.19.jar
Unable to perform this operation due to the following problem.
EDC5147I Illegal byte sequence. (errno2=0xC25F002E)
Illegal character sequence detected by iconv()

Response From Service
category: 16
rc:       147
reason:   -1033961426
message:  Illegal character sequence detected by iconv()
details: 
  - EDC5147I Illegal byte sequence. (errno2=0xC25F002E)

Diagnostic Information
Received HTTP(S) error 500 = Internal Server Error.

Protocol:          https
Host:              ***
Port:              ***
Base Path:         
Resource:          /zosmf/restfiles/fs/z%2Fz60636%2Fcobolcheck%2Fbin%2Fcobol-check-0.2.19.jar
Request:           PUT
Headers:           [{"X-IBM-Data-Type":"text"},{"Content-Type":"text/plain"},{"Accept-Encoding":"gzip"},{"X-CSRF-ZOSMF-HEADER":true}]
Payload:           undefined
Allow Unauth Cert: true
Available creds:   user,password,base64EncodedAuth
Your auth order:   basic,token,bearer,cert-pem
Auth type used:    basic
Error: Process completed with exit code 1.
