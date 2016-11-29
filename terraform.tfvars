region = "us-central1"
zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
project = "your-gcp-project"
dns_suffix = "gcp.pcf-bosh.cf-app.com"
ssl_cert = <<SSL_CERT
-----BEGIN CERTIFICATE-----
MIIDcTCCAlmgAwIBAgIJAP3DwcS6Yg+8MA0GCSqGSIb3DQEBBQUAMEUxCzAJBgNV
BAYTAkFVMRMwEQYDVQQIEwpTb21lLVN0YXRlMSEwHwYDVQQKExhJbnRlcm5ldCBX
aWRnaXRzIFB0eSBMdGQwIBcNMTYxMTI5MjM1NDAyWhgPMjI5MDA5MTMyMzU0MDJa
MEExCzAJBgNVBAYTAlVTMRAwDgYDVQQKEwdQSVZPVEFMMSAwHgYDVQQDExdnY3Au
cGNmLWJvc2guY2YtYXBwLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALPBeEEkvvF6Ol6Etq1gAiUv2SZJGBxhPZ+r2AApn5O+vgVcy6sg2zJJJqXj
Nas6DlXEbCItRz51ACDMfJ9w4koznMtSjUw9BzeAppG8qfQL/rBnAr2EiNKvIM3u
qKs11d8iX58TJH978srDRWRfp9aXRpixcSW2Dt06D24ylMJU7ekee31Yq53gm7oA
JU7hQOcgf1TDxtxndV7VqlPeOPYznbJAwxDj/jBzJt71uLB/M28cm++tFqaWRDWt
jmQYN741aqOjNPBjddRLc0fz0ycfjxy5Ua198bKY9vjOtLY3NptVTmvwsa6Id/Ex
TjcaepOL+Hvjb6wV/l34StvzRgsCAwEAAaNmMGQwYgYDVR0RBFswWYIZKi5nY3Au
cGNmLWJvc2guY2YtYXBwLmNvbYIdKi5zeXMuZ2NwLnBjZi1ib3NoLmNmLWFwcC5j
b22CHSouYXBwLmdjcC5wY2YtYm9zaC5jZi1hcHAuY29tMA0GCSqGSIb3DQEBBQUA
A4IBAQBXTWtxVJJWHLHpVfOplqntcMGV6M9551EHeL9YE1SVmI2ZjqSKxbvRAkCb
aIlGLTU5T2Q6d98K5JgyvxQlkS3mFFeNAKAkNeUCNa8jhjqbo35vsFXbmiK9W7cD
WcrP8n84Gs6gn5bQpUDEPtx2n4QVNrneUWK3btgER+rQJ2DskXar+8dOapEwmQrj
NOMmG25Ac1euR/qf5hgQ0gELhN6F7kqEuaTFRhdDyF/k5Lcf0fYP7ZNBxMwPFQI8
5IdNqgw+Yg4R55TYsiYsnvIYe8mgGhPI2fDM0q0KWlgAV8ovMyKNnD5iN4jRkPVH
NOkwG40JTLR0o/ck8u/5E8dsHHvs
-----END CERTIFICATE-----
SSL_CERT
ssl_cert_private_key = <<SSL_KEY
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAs8F4QSS+8Xo6XoS2rWACJS/ZJkkYHGE9n6vYACmfk76+BVzL
qyDbMkkmpeM1qzoOVcRsIi1HPnUAIMx8n3DiSjOcy1KNTD0HN4Cmkbyp9Av+sGcC
vYSI0q8gze6oqzXV3yJfnxMkf3vyysNFZF+n1pdGmLFxJbYO3ToPbjKUwlTt6R57
fVirneCbugAlTuFA5yB/VMPG3Gd1XtWqU9449jOdskDDEOP+MHMm3vW4sH8zbxyb
760WppZENa2OZBg3vjVqo6M08GN11EtzR/PTJx+PHLlRrX3xspj2+M60tjc2m1VO
a/Cxroh38TFONxp6k4v4e+NvrBX+XfhK2/NGCwIDAQABAoIBAACN1hsNS/FemRN1
gUKjix4mOZsemo5r1k7Jrs7BUhaYfelyUcZjQYm0JARa4O14LlchVdv9G70bizaO
qsurA2eLJS6TQJA9l+oZ4WmNlVCFQPG2P5Hp+Kn9lDJOTALLFa+sYXMSEgi6jxME
6w/WI6RLrxIFaf3dw8n2xdlnGoJG02mHBSUss5BY8HkDX32yh+gE2YNbIkGeDJuF
yP4lNaT5CChRnrcEn+BtgwA7S5i2Pu4CHlvsgOiOTEXQnmlAB0ujIXnwQ7b26Z3t
h7JzReQbEXKFuqdRzRSGmKdn02eNpn/uU2oRYXYoWqAW6M2isZa7EidlmsmYhOos
SVStwtECgYEA5ihvj2zt6Wii9XuXoyJN9kW/EXVZETGuxOVUyOql+b3b9I9hIE9x
7L05MPVHCswYGHzcK/otbl/YHMam6bx09ZyuZp2CmuQZNEI632PatpZXeqVKjkGA
a0tI1BIVT3XXMiWJE2TtWtA98fPDCNctnEjDloVkx7Ie9G5ST6XqZ9cCgYEAx/BL
N9tiOAHo92mxX935Lg1poE4fKU8WL7/55AilgOPXft64Tk2wTPK787QUSH83Zqnz
7qNL6NWwbkLOmCXQMM/g2h1Ehr90m8DFA3DPLI+Q4kraQ1w0x+Pryi+fBbizmAAo
Ts4+O5J8OWNoEf22Fsit6j3FZI3agrjl+fzjfO0CgYEAgsSuvhryAhAFptyWB4ZS
LX7rVIwMEwzbc9upFI7dxsvs0UM1uBnrbMsGV57Ewom7lw46OnJmpbOnIpJr+5ms
CnD/ViZgMokvGNYYhRxDBELfaTvI5JKq2EtqEbREj2Uw47kX7QEHKvXufC43viok
LAvbtQYNgLjfhZm5ArAOQvkCgYEAq1c27qhYNI0We6ic8/4DA79EzLcGJ116MvN/
EDeEtb8LttLg+WHEezztazzgwPwcmyN8Qv64F9HAv80KxQJqttn+5Ix+ZEeAg9Wg
QIGVWaeyzuq8v0suhDrDn2JOEhYl+lXwNRCz7lNrl7ajwf8946qYuAu1tKWII8yW
cTSSM0UCgYEArXmC/ce9mpe3+CArWq2s5ro2qOpJw4jhDePi0XzBhEcIPDhc8iwG
euW/spNkc8KBF1aNuoI4lqFG08yWXr6hr9VG41fhdKvQfiIZOSDrQ668yzvY67ow
UnRO7uVGeSnUdAq7st7IAPO9zQID8Iw+bbtUCWgw4dI0gAYQQtgzOKs=
-----END RSA PRIVATE KEY-----
SSL_KEY
service_account_key = <<SERVICE_ACCOUNT_KEY
{
  "type": "service_account",
  "project_id": "your-gcp-project",
  "private_key_id": "another-gcp-private-key",
  "private_key": "-----BEGIN PRIVATE KEY-----another gcp private key-----END PRIVATE KEY-----\n",
  "client_email": "something@example.com",
  "client_id": "11111111111111",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://accounts.google.com/o/oauth2/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/"
}
SERVICE_ACCOUNT_KEY
