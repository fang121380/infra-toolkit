# Operations checklist

## Before applying

- Confirm the switch port is configured for the intended EAP method and fallback VLAN behavior.
- Confirm the RADIUS server expects EAP-TLS and the exact identity format.
- Verify the certificate chain and private-key permissions.
- Keep local console access available in case the profile disconnects the host.
- Test on one non-production host before PXE or fleet rollout.

## After applying

```bash
nmcli connection show --active
nmcli -f GENERAL,802-1X connection show corp-wired-8021x
journalctl -u NetworkManager --since -10m
```

A successful DHCP lease does not by itself prove 802.1X policy is correct. Confirm the switch and RADIUS logs show an accepted EAP-TLS session and the expected VLAN.

## Rollback

List profiles with `nmcli connection show`, reactivate the previous profile, then remove the generated profile only after network access is restored:

```bash
sudo nmcli connection up '<previous-profile>'
sudo nmcli connection delete corp-wired-8021x
```
