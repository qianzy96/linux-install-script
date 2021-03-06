#!/bin/sh
set -e
#
# Please run as root!
#

cd /tmp

apt update
# install old version:
apt install -y openvpn
# remove old version:
apt remove -y openvpn
# install new version:
wget http://ftp.cn.debian.org/debian/pool/main/o/openvpn/openvpn_2.4.0-6+deb9u3_arm64.deb
dpkg -i openvpn_2.4.0-6+deb9u3_arm64.deb
rm -f openvpn_2.4.0-6+deb9u3_arm64.deb

if [ ! -f "/etc/openvpn/pwd.conf" ]; then
sudo cat > /etc/openvpn/pwd.conf<<EOF
username
password
EOF
fi

if [ ! -f "/etc/openvpn/client.ovpn" ]; then
sudo cat > /etc/openvpn/client.ovpn<<EOF
client
nobind
dev tun
remote-cert-tls server
remote ov.abc.com 11194 udp

# cjy add
resolv-retry infinite
persist-key
persist-tun
cipher AES-256-CBC
verb 3
comp-lzo no
auth-user-pass /etc/openvpn/pwd.conf
# auth-retry nointeract
reneg-sec 0

<key>
-----BEGIN PRIVATE KEY-----
MIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQC1UCl5Pb7Et1re
5tnZUeiPySbs5WmCV9h+4odAqLEri3C1tWpPrCzYnr6V/ytZDpdGIvTDnJoLPN2k
oUR1PuEvCOGkj3uvihXMJlXkq9IDHtpq5L71p9y1yQFvVeNlvz0fEzGFX0WTs003
mBCAWH6Jg3i4kHmScp7DIM+AS1CEGXClHYbl7/LPccK7YTjdMBvEYC53+e3EJV3h
3WrDvyPCTzPey5drtjMU0SLTYEN93qz3Bm9zgLtuDbw3LX3c2+a9BZq22QXMSgik
CzRStzNsYgu6AqTrZH+lMPmngYx9iU3aCeuImPpj+6rWQ4YeGT2T2dAcjV0+Mcib
LipIPSmNAgMBAAECggEBAJnkwm7/843wuxZ7BukoVqbEa1+jkRxrB30bNQWyqT52
imIQ631YfHAYvVd/UAG1Gr0TKoFlyHJFZTM5FmwVxPgxJ6SPjMIACGRRHZKMLCMt
6uHT6imEIxfA1pDza6GO4ogfuGal6N5mz+GiFk95zV1W0/6D0kx1MUAZ90XDp0GX
Dh0wxsgZnxC4EN7fGUk+ZVYtcEngI1o0luC4cJOO8eCq3NszhHKLIF8AmF3nbJmK
rveBnN2ghF6dJ/kO681ONNtdIyZRNbQoKhOAoWhyH9FfMJIAsip9DrIKCSEeDLx6
ki7e6JdYGd1f4E/FM/H9sh6EJotaHIDrUk79OuCMsAECgYEA8ZfTZHCs+d7tssGZ
Nq5byxNnZHmtY4pN5CRYgMUeLtdVC+hhClSwMZ+q5g7bejbbdEczODN9yVcs1aKa
va9VBzEPEC/vU6Imdu/sWf9Jta+J86wA0M0XYLZCqzTF37CNUuhcohlvZL8nKTj5
BHuVmpS7dnNmMzPsvsDICQsTx40CgYEAwCAZYSBU14RcG7muttzBfVt1xcDZUt6Z
dgQHCfO7puBL92QaPFvFxg+9psfjcPUY7EMsq8VppcfARyH+X3niy84wL3r0bZhj
lY1zK2SFtN+5UKDUKkZOjR9cVrxoiHDxtuFveRovVOmIS8CXhTNa7OphRSDQwTBZ
SqQWGUvtagECgYAqypGOwMZim7HOb6wLm2Z22cD+cu7bKqwRNL7YUBHAijNuIILP
qaBrqbRDe240f3LvbY0M71HgT6iJTnvKDTwqQe5BF7x0O8xEVMqwRh9wJt9wYY7j
bPAvGRlF6dsCe+sMPEvsCkVIuvLcwlKZEKq27pElsdrwRsowH0VPFL80IQJ/apFj
gnxskx7X+IkGYGgS63XP3eEaqtzOQqf5P4vyip3fhVoBM3m0OiiBCgHWJtHNAUBB
hwX5k/s4rDwu3Ma/Bk1YbP3GlwPwOQQ83dTkVW/DWvXauZhF+gFrNrFLSmNbsBVb
v9DGcFMZRuuNIFVcGg3n5nBNWtt2q/BYUa/MAQKBgFl8ySOfOIKYhfu/2iV2kO21
6CAVenZmoXPQbO17YfcM3f5PVo/XwsNf4u0GvGwOfOuzW33bMgRuo2Q2/MohXRjC
7DDL+MMF0G/kkq0kcXKgFkSTDaShQ4LkA5yGna57Qp/y0b8pBXUy1J/Pnz2PNT5h
hoe+xszMca71/aMimTEa
-----END PRIVATE KEY-----
</key>
<cert>
-----BEGIN CERTIFICATE-----
MIIDWjCCAkKgAwIBAgIQC9bkzmcG+Nm6Tvmrlvfv4TANBgkqhkiG9w0BAQsFADAZ
MRcwFQYDVQQDDA5vdi5pZGVyZWNrLmNvbTAeFw0xOTAzMDUwMjUwNDZaFw0yMjAy
MTcwMjUwNDZaMBExDzANBgNVBAMMBmNsaWVudDCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBALVQKXk9vsS3Wt7m2dlR6I/JJuzlaYJX2H7ih0CosSuLcLW1
ak+sLNievpX/K1kOl0Yi9MOcmgs83aShRHU+4S8I4aSPe6+KFcwmVeSr0gMe2mrk
vvWn3LXJAW9V42W/PR8TMYVfRZOzTTeYEIBYfomDeLiQeZJynsMgz4BLUIQZcKUd
huXv8s9xwrthON0wG8RgLnf57cQlXeHdasO/I8JPM97Ll2u2MxTRItNgQ33erPcG
b3OAu24NvDctfdzb5r0FmrbZBcxKCKQLNFK3M2xiC7oCpOtkf6Uw+aeBjH2JTdoJ
64iY+mP7qtZDhh4ZPZPZ0ByNXT4xyJsuKkg9KY0CAwEAAaOBpTCBojAJBgNVHRME
AjAAMB0GA1UdDgQWBBS5G5YBUMamv+3lP41HZODbRX5Y/jBUBgNVHSMETTBLgBQ7
WMYsz+oZf56NHnEFh+oXCnKG/aEdpBswGTEXMBUGA1UEAwwOb3YuaWRlcmVjay5j
b22CFDme6LEHjwxa97Qlp7I8Ba7XcUbqMBMGA1UdJQQMMAoGCCsGAQUFBwMCMAsG
A1UdDwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAqJCv8OXfLkEcn3TeST4Mvzis
YaRsA6jahaGCfWVG9RtbXf4Cj5z4MUe/58Pe2yac8fDMFcHhWNGZoUHDBMjhXEjj
uZO9Qzhw/5FIoOidG9PREYT3L49apNavGoyCclKx2zUvaPkTPncQgMFT04xpYnYi
PmspdUktVd0NRxVNYtVISDrY+UwC5fCJTlevbg1cHu5eNQI9T6ySd9B2j8An+g30
pB2cuNfmcbf/RTccvq51UHmNJN3t3MOS7xRjoEUuGKDnOwE5OnMJhTbTh/h4Fl8d
+RQ4qUxQ4szD7bxfnpo/sU0duOpyuoNmXgU3u0cUtEZ9RVsxTvUMFsWHnh0ZBQ==
-----END CERTIFICATE-----
</cert>
<ca>
-----BEGIN CERTIFICATE-----
MIIDVDCCAjygAwIBAgIUOZ7osQePDFr3tCWnsjwFrtdxRuowDQYJKoZIhvcNAQEL
BQAwGTEXMBUGA1UEAwwOb3YuaWRlcmVjay5jb20wHhcNMTkwMzA1MDIyNDIwWhcN
MjkwMzAyMDIyNDIwWjAZMRcwFQYDVQQDDA5vdi5pZGVyZWNrLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAMNguY9qJs/CJvn8Yg1Ga4pJtQEnXXnn
KAoiQYMC8InQJoVK0lbUG+1vWoRD7ISGewJzOkcdw/1Bz8kajWFkWEuUsk0GtPjz
QIpEuqipzFp5KmN+wcwIe0cWC/1owaOydGWliFG58iDYwaWcwFQWrY5X4/Qe7iHp
Dhk8f3qaobHdBkN9IwoGdKTNL2acqxm1mYDPQjONJ/rHcKcPzE8+qDJdLv6lE2Gi
aD3qYA4q3nreGccZrx347U0qSaSecUxbTZUMoVOSKB09KJmIu4ng4tJw8LR2ui0r
FHElnl59LGrFUO0F2p/qD5HpTmcRdLlZUmlx26pkNnA7x3er4oT0YZECAwEAAaOB
kzCBkDAdBgNVHQ4EFgQUO1jGLM/qGX+ejR5xBYfqFwpyhv0wVAYDVR0jBE0wS4AU
O1jGLM/qGX+ejR5xBYfqFwpyhv2hHaQbMBkxFzAVBgNVBAMMDm92LmlkZXJlY2su
Y29tghQ5nuixB48MWve0JaeyPAWu13FG6jAMBgNVHRMEBTADAQH/MAsGA1UdDwQE
AwIBBjANBgkqhkiG9w0BAQsFAAOCAQEAgJNvYxrub2SCc63dXLRl6+0Io3W8ZkN8
+7tq756qIcWHJZoVExBPvSVlWjfhXG9DFiFUtNfPXoBHkNLvJnaAuyq67VB1d8JI
6n3c06hJGafyXO1RlzVxGnQFGSwz1G1MFK4HPKz1d4afJe0VSDOuGcTK3EfJiTWb
LuZFx7pyL9nJjf4smWfvAmCgs2C7hbqnc4CJLhodySAr9VA9KvxcouFtscjz4bPl
p+5O67/yU1KMJIJ/jypapjtqKYRkfEnLEV3dKPy4hfmxxuyU1DOcczI2VmHImICz
eYV+5bq0id8u/QMAlLg8/gpQm+Hp/wE5h7GpKa+vX1DP2o3Xum926Q==
-----END CERTIFICATE-----
</ca>
key-direction 1
<tls-auth>
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
ca86754f1c6744b3636b84eda15677a1
5f0d5ad81eefb0786ead55125958a924
f4e567b7e484c1d123a6b823ab1d862c
db43e61125e6242685d0f5e482229af1
1bee65ae7510035a10a2c424e029edf0
486b0617b9428a29ec747fd9ca80cca2
f88f5be4310e3a3e5917b88df83ae480
7b87345bf0e588f69ba726b493c763ea
7152abb67a011dec3f2b42e476640721
aa2298d15ba7561ea32b490d79ae91e0
5adc15d822a576d5eda729bed50ed55f
00e65b343ee5f46d0380f1a981a368ca
b3fee14da3373c54429ebb7cbb896aa3
f52723d5d64ad4c2d2b26dcd59be99b4
c9d10d8b15bc7c416327a2b5bb1d1f4c
cfe7e249b30bef85d31e23672552d97b
-----END OpenVPN Static key V1-----
</tls-auth>
#redirect-gateway def1
EOF
fi

echo '*********************************************************************************************************'
echo 'Please modify "username" and "password" in "/etc/openvpn/pwd.conf"'
echo 'Please modify "/etc/rc.local" to add: "openvpn --daemon --config /etc/openvpn/client.ovpn --log /tmp/openvpn-client.log"'
echo '*********************************************************************************************************'
