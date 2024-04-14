#!/bin/bash
if [ "${PAM_TYPE}" = "open_session" ]; then
  curl \
    -H prio:high \
    -H tags:warning \
    -H "Authorization: Bearer YOUR_TOKEN_HERE" \
    -d "SSH login: ${PAM_USER}@$(hostname) from ${PAM_RHOST}" \
    https://ntfy.jayparry.dev/alerts
fi