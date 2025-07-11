# Boilerplate for Python Package

## Installation

1. Create a new repository on GitHub using the template.

2. Install [uv](https://docs.astral.sh/uv/) if you haven't already.

   > If you are in the state of installing make, you can replace steps 3-5 with
   `make install`.

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

6. Replace the project information with your own.

    - Change the directory name `myproject` under `src`.

    - Update the project name `myproject` and authors in pyproject.toml.

    - Update the `name` field in `.devcontainer/devcontainer.json`.

7. Update the `README.md` file with your project information.

## Usage

Refer to the commands in the [Makefile](./Makefile) for tasks.
