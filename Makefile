.PHONY: type-check
type-check:											## Run mypy
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
