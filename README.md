## 🔐 Gitleaks Pre-commit Hook Setup

This repository contains a ready-to-use **pre-commit hook** that automatically scans your changes for secrets using [Gitleaks](https://github.com/gitleaks/gitleaks).

### ✅ One-step installation

To install and configure everything **automatically**, just run the following command in your terminal:

```bash
curl -sSfL https://raw.githubusercontent.com/savkaviktor16/gitleaks-check/main/install.sh | bash
```

This script will:

- install [Gitleaks](https://github.com/gitleaks/gitleaks/releases) based on your OS (Linux, macOS, or Windows Git Bash),
- create `.githooks/` directory and place the `pre-commit` hook script there,
- link it to `.git/hooks/pre-commit`,
- ensure it's executable.

> 💡 **Gitleaks will scan files before each commit and block commits if secrets are found.**

---

### 💻 Platform Requirements

| Platform | Requirements                                               |
| -------- | ---------------------------------------------------------- |
| Linux    | ✅ `curl`, `tar`, standard shell                            |
| macOS    | ✅ `curl`, `tar`, standard shell                            |
| Windows  | ⚠️ **Requires **[**Git Bash**](https://gitforwindows.org/) |

> ⚠️ On Windows, the script **must be executed inside Git Bash** — PowerShell or Command Prompt are not supported.

---

### 🧪 Verifying installation

After installation, try:

```bash
gitleaks version
```

If the command prints a version (e.g. `v8.27.2`), Gitleaks is correctly installed.

Also try staging a file and running:

```bash
git commit -m "Test secret"  # The pre-commit hook will trigger
```

If a secret is found, the commit will be blocked with a detailed report.

---

### 🛉 Uninstall (optional)

To remove the pre-commit hook:

```bash
rm .git/hooks/pre-commit
```

To remove Gitleaks manually:

- Delete the binary from `~/bin/gitleaks`
- Optionally, remove any PATH edits from your shell config (`~/.bashrc`, `~/.zshrc`, etc.)
