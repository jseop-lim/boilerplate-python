# Boilerplate for Python Package

<!-- Core Technologies -->
[![Python](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/jseop-lim/boilerplate-python/blob/main/LICENSE)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json&label=managed%20by&labelColor=grey&color=blue)](https://github.com/astral-sh/uv)

<!-- Code Quality -->
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
[![MyPy](https://img.shields.io/badge/mypy-checked-blue.svg)](http://mypy-lang.org/)
[![Pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)

<!-- Development Environment -->
[![Dev Container](https://img.shields.io/badge/dev%20container-supported-blue?logo=visualstudiocode)](https://code.visualstudio.com/docs/devcontainers/containers)
[![Make](https://img.shields.io/badge/automation-make-blue.svg)](https://www.gnu.org/software/make/)

<!-- CI/CD Status -->
[![CI](https://github.com/jseop-lim/boilerplate-python/actions/workflows/ci.yml/badge.svg)](https://github.com/jseop-lim/boilerplate-python/actions/workflows/ci.yml)

<!-- markdownlint-disable MD033 -->
<details>
<summary>Table of Contents</summary>

- [Getting started](#getting-started)
  - [Option 1: Local Development](#option-1-local-development)
  - [Option 2: Dev Container Development](#option-2-dev-container-development)
  - [Next Steps (for both options)](#next-steps-for-both-options)
- [Usage](#usage)
  - [Running the Application](#running-the-application)
  - [Changing Python Version](#changing-python-version)
  - [Development Commands](#development-commands)
- [Acknowledgments](#acknowledgments)

</details>
<!-- markdownlint-enable MD033 -->

## Getting started

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
   chmod +x scripts/rename_project.sh && \
   ./scripts/rename_project.sh
   ```

   This will prompt you for:
   - Project name
   - Author name
   - Author email

   The script automatically:
   - Renames the `src/my_project` directory
   - Updates project name and author info in `pyproject.toml`
   - Updates the container name in `.devcontainer/devcontainer.json`
   - Regenerates the lock file

2. Update the `README.md` file with your project information.

3. (Optional) If you want to manage dependency versions manually instead of
   using automated version upgrades:

   ```shell
   chmod +x scripts/remove_dependabot.sh && \
   ./scripts/remove_dependabot.sh
   ```

   This will remove:
   - `.github/dependabot.yml` configuration file
   - `.github/workflows/update-pre-commit.yml` workflow file

## Usage

### Running the Application

You can run the `main()` function defined in
[`__init__.py`](./src/my_project/__init__.py) using:

```shell
uv run my-project
```

The entry point is defined in [`pyproject.toml`](./pyproject.toml) under
`[project.scripts]`. You can customize it by modifying the script configuration:

```toml
[project.scripts]
my-project = "my_project:main"
your-custom-command = "my_project:your_function"
```

For more details on project scripts and entry points, refer to [PEP 621](https://peps.python.org/pep-0621/#entry-points).

### Changing Python Version

You can change the Python version used in the project using the interactive script:

```shell
chmod +x scripts/change_python_version.sh && \
./scripts/change_python_version.sh
```

This will prompt you for the new Python version (e.g., 3.13.1) and automatically:

- Update `.python-version` file
- Update Python version settings in `pyproject.toml`
- Update Python version in `.github/workflows/ci.yml`
- Remove and recreate the virtual environment
- Install the specified Python version (if not already available)
- Sync dependencies with the new Python version

### Development Commands

Refer to the commands in the [`Makefile`](./Makefile) for development tasks.

## Acknowledgments

This boilerplate was inspired by:

- [8percent/python-library](https://github.com/8percent/python-library)
- [litestar-org/litestar](https://github.com/litestar-org/litestar)
