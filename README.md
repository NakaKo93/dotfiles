# dotfiles
## Windows Usage
These scripts are intended for Windows with Git Bash.

### bootstrap
- Install required tools and external dependencies.
- Installs Scoop (if not already installed)
- Installs development tools (ripgrep, vscode, etc.)
- Installs fzf and z (if configured)
- Prepares the environment before applying dotfiles
```bash
./scripts/windows/bootstrap.sh
```
Run this once when setting up a new machine.

### install
Copy dotfiles from this repository to your local $HOME.
- Existing files will be backed up with .bak
- Files are copied to $HOME
```bash
./scripts/windows/install.sh
```

### update
Sync local changes back to this repository.
- Copies modified files from $HOME
- Intended for committing changes to Git
```bash
./scripts/windows/update.sh
```
