.PHONY: install
install:  											## Install dependencies
	@echo "=> Installing dependencies"
	@uv sync
	@echo "=> Installing pre-commit hooks"
	@uv run pre-commit install
	@echo "=> Setting up git commit template"
	@git config commit.template .gitmessage
	@echo "=> Dependencies installed"

.PHONY: upgrade
upgrade:       										## Upgrade all dependencies to the latest stable versions
	@echo "=> Updating all dependencies"
	@uv lock --upgrade
	@echo "=> Dependencies Updated"
	@uv run pre-commit autoupdate
	@echo "=> Updated Pre-commit"

.PHONY: lock
lock: 												## Lock dependencies
	@echo "=> Locking dependencies"
	@uv lock
	@echo "=> Dependencies locked"

.PHONY: export
export: 										   ## Export the lock file to requirements.txt
	@echo "=> Exporting lock file to requirements.txt"
	@uv export --format requirements-txt -o requirements.txt
	@echo "=> Exported lock file to requirements.txt"

.PHONY: type-check
type-check:											## Run type checkers
	@echo "=> Running mypy"
	@uv run mypy .
	@echo "=> mypy complete"

.PHONY: pre-commit
pre-commit: 										## Runs pre-commit hooks
	@echo "=> Running pre-commit process"
	@uv run pre-commit run --all-files
	@echo "=> Pre-commit complete"

.PHONY: lint
lint: pre-commit type-check							## Run all linting

.PHONY: test
test:  												## Run the tests
	@echo "=> Running test cases"
	@uv run pytest tests
	@echo "=> Tests complete"
