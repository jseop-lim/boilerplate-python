# Boilerplate for Python Package

## Installation

1. Create a new repository on GitHub using the template.

2. Install [uv](https://docs.astral.sh/uv/) if you haven't already.

3. Create a new virtual environment and install the dependencies.

   ```shell
   uv venv
   uv sync --all-groups
   ```

4. Install [pre-commit](https://pre-commit.com/) hooks.

   ```shell
   pre-commit install
   ```

5. Apply the git commit message template.

   ```shell
   git config commit.template .gitmessage
   ```

6. Replace `myproject` with the name of your project.

7. Update the `README.md` file with your project information.
