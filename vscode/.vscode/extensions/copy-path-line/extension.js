const vscode = require('vscode');

function activate(context) {
  const disposable = vscode.commands.registerCommand('copy-path-line.copy', async () => {
    const editor = vscode.window.activeTextEditor;
    if (!editor || !editor.document) {
      return;
    }

    const filePath = editor.document.uri.fsPath;
    const selection = editor.selection;

    let result;
    if (selection.isEmpty) {
      const line = selection.active.line + 1;
      result = `${filePath}:${line}`;
    } else {
      const startLine = selection.start.line + 1;
      let endLine = selection.end.line + 1;

      // Handle full-line selection where end position wraps to column 0 of succeeding line
      if (selection.end.character === 0 && selection.end.line > selection.start.line) {
        endLine = selection.end.line;
      }

      if (startLine === endLine) {
        result = `${filePath}:${startLine}`;
      } else {
        result = `${filePath}:${startLine}:${endLine}`;
      }
    }

    await vscode.env.clipboard.writeText(result);
    vscode.window.setStatusBarMessage(`Copied: ${result}`, 2000);
  });

  context.subscriptions.push(disposable);
}

function deactivate() {}

module.exports = { activate, deactivate };
