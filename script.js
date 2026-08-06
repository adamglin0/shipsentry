function attachCopyButton(buttonId, valueId, successLabel) {
  const button = document.getElementById(buttonId);
  const value = document.getElementById(valueId);

  button.addEventListener("click", async () => {
    const originalLabel = button.textContent;
    try {
      await navigator.clipboard.writeText(value.textContent.trim());
      button.textContent = successLabel;
    } catch {
      const selection = window.getSelection();
      const range = document.createRange();
      range.selectNodeContents(value);
      selection.removeAllRanges();
      selection.addRange(range);
      button.textContent = "Selected";
    }
    window.setTimeout(() => { button.textContent = originalLabel; }, 1600);
  });
}

attachCopyButton("copy-command", "install-command", "Copied");
attachCopyButton("copy-wallet", "wallet-address", "Copied");

