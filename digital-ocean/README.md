# DigitalOcean

If your VPS is hosted as a DigitalOcean droplet, then these bash scripts can help you set that up

## Firewalls & Cloudflare

I originally intended to just use [UFW](https://help.ubuntu.com/community/UFW) on my vps, but I realised Docker and UFW don't play well together straight out of the box.  
In short, Docker bypasses UFW rules, and any host ports exposed are exposed to the public.  
I went down the rabbithole, and found that there's quite a lot of discussion on this. The following links go into way more detail on the issue:

- <https://github.com/moby/moby/issues/4737>
- <https://github.com/chaifeng/ufw-docker?tab=readme-ov-file#problem>

I couldn't be bothered to get Docker and UFW to work together, so I've decided to let my hosting service take care of that.

**NOTE:** This relies on the fact that you're using Cloudflare to proxy all incoming requests.

---

The `setup-cloudflare-firewall.sh` is a script that uses [`doctl`](https://docs.digitalocean.com/reference/doctl/) to setup a firewall that only allows inbound HTTP and HTTPS traffic from [trusted Cloudflare IP ranges](https://developers.cloudflare.com/fundamentals/concepts/cloudflare-ip-addresses/) + some other basic inbound and outbound rules (i.e SSH)

**NOTE:** `doctl` and related scripts are intended to be installed and run on _your_ PC, **not** the VPS

1. Install [`doctl`](https://docs.digitalocean.com/reference/doctl/how-to/install/)
2. Create a [personal access token](https://docs.digitalocean.com/reference/api/create-personal-access-token/)
3. Use the API token to grant account access to doctl.
   Pass in the token string when prompted by doctl auth init, and give this authentication context a name.

   ```bash
   doctl auth init --context <CONTEXT_NAME>
   ```

   ```bash
   doctl auth list
   doctl auth switch --context <CONTEXT_NAME>
   ```

4. Run the Cloudflare firewall setup script

   ```bash
   ./setup-cloudflare-firewall.sh
   ```
