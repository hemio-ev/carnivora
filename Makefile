SHELL=/bin/bash

dev-gen-html-docs:
	mkdir -p docs/schemas
	mkdir -p docs/schemas_system
	rm -f docs/schemas/*.rst
	rm -f docs/schemas_system/*.rst
	./dev/all-schemas-hamsql-setup.py | hamsql doc -s - -o docs/schemas
	mv docs/schemas/{backend,commons,system,user}.rst docs/schemas_system
	rm -r docs/_build
	make -C docs html

dev-gen-docs: dev-gen-html-docs
	make -C docs man
	make -C docs latex
	make -C docs/_build/latex
