# Boilerplate for Python Package

## Installation

### Option 1: Local Development

1. Create a new repository on GitHub using the template.

2. Install [uv](https://docs.astral.sh/uv/) if you haven't already.

   > If you have make installed, you can replace steps 3-5 with `make install`.

3. Create a new virtual environment and install the dependencies.

   ```shell
   uv sync
   ```

   `uv sync` creates a virtual environment(`.venv`) if the project virtual environment
   does not exists.

4. Install [pre-commit](https://pre-commit.com/) hooks.

   ```shell
   pre-commit install
   ```

5. Apply the git commit message template.

   ```shell
   git config commit.template .gitmessage
   ```

### Option 2: Dev Container Development

1. Create a new repository on GitHub using the template.

2. Make sure you have [Docker](https://www.docker.com) and
   [VS Code](https://code.visualstudio.com) with the
   [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   installed.

3. Open the project in VS Code and select "Reopen in Container" when prompted,
   or use the command palette (`Ctrl+Shift+P` / `Cmd+Shift+P`) and run
   "Dev Containers: Reopen in Container".

   The dev container will automatically:
   - Set up the Python environment with uv
   - Install all dependencies
   - Configure pre-commit hooks
   - Apply git commit template

### Next Steps (for both options)

1. Customize the project information using the interactive setup script.

   ```shell
   chmod +x scripts/rename_project.sh
   ./scripts/rename_project.sh
   ```

   This will prompt you for:
   - Project name
   - Author name
   - Author email

   The script automatically:
   - Renames the `src/myproject` directory
   - Updates project name and author info in `pyproject.toml`
   - Updates the container name in `.devcontainer/devcontainer.json`
   - Regenerates the lock file

2. Update the `README.md` file with your project information.

## Usage

Refer to the commands in the [Makefile](./Makefile) for tasks.
