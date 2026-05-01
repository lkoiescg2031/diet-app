.PHONY: install-project-skills install-skills test-project-skill-install

install-project-skills:
	@./scripts/install-project-skills.sh

install-skills: install-project-skills

test-project-skill-install:
	@bash tests/install-project-skills.test.sh
