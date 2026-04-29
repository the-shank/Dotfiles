---
name: send-slack-notification
description: Sends a Slack notification using the local send_slack_notification.sh helper script. Use when the user asks to notify Slack, send a Slack update, or when the workflow requires notifying that we are waiting for permissions or confirmations.
---

# Send Slack notifications

## Preconditions

Confirm the helper is available on PATH:

```bash
command -v send_slack_notification.sh
```

Confirm the Slack webhook is configured:

```bash
test -f ~/.slack_notification_webhook
```

If `~/.slack_notification_webhook` is missing, instruct the user to run:

```bash
setup_slack_notifications_webhook.sh
```

## Send a message

`send_slack_notification.sh` takes exactly one required argument, the message text.

Prefer a short, concrete message that includes what is blocked and what is needed next.

```bash
send_slack_notification.sh "Waiting for approval to run: just test-all"
```

## Message patterns

- **Permission needed**: "Need approval to run: <command>. Reason: <why>."
- **Waiting for confirmation**: "Waiting for confirmation: <decision>."
- **Long-running job started**: "Started: <job>. Next update at: <time or milestone>."

## Notes

- Always quote the message so spaces and punctuation are preserved.
- Avoid newlines and unescaped quotes in the message text.
