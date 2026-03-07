return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "auto",
      -- Enable tool calling for the @copilot agent
      -- This allows the AI to propose bash commands which you then approve
      tools = {
        bash = {
          enabled = true,
        },
      },
    },
  },
}
