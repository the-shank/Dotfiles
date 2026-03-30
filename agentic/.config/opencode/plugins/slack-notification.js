import { appendFile } from "node:fs/promises";
import { basename } from "node:path";
import { hostname } from "node:os";
import { inspect } from "node:util";

export const NotificationPlugin = async ({ project, client, $, directory, worktree }) => {
  return {
    event: async ({ event }) => {
      const SLACK_WEBHOOK_URL = process.env.SLACK_WEBHOOK_URL;

      let slackMessage = "";

      if (event.type === "permission.asked") {
        slackMessage = "Permission required";
      }

      // Only send if we have a message and a valid Webhook URL
      if (slackMessage && SLACK_WEBHOOK_URL) {
        const projectLabel = `OPENCODE :: ${basename(directory ?? worktree ?? ".")} @ ${hostname()}`;
        const payload = JSON.stringify({
          text: `*${projectLabel}*\n${slackMessage}`
        });

        try {
          // .quiet() prevents curl output from cluttering your terminal
          await $`curl -s -X POST -H 'Content-type: application/json' --data ${payload} ${SLACK_WEBHOOK_URL}`.quiet();
        } catch (error) {
          console.error("Slack Notification Error:", error);
        }
      }
    },
  };
};
