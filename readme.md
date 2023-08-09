A simple little proxy to access Railway internal networks via Tailscale.
Useful for development and testing of services that aren't exposed via the public internet.

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/IyUAJX?referralCode=mg)

Setup Instructions:

- Create a new API key from Tailscale dashboard
- Deploy project, set `TAILSCALE_API_KEY`
- Within Tailscale dashboard,
  - Approve subnet range for the machine
  - Add a new nameserver within DNS settings, `fd12::10`, restrict to `railway.internal`

Should be it!

Future work:

- Support persistent storage state (i.e. no need to re-auth on restart)
- Integrate into CLI
