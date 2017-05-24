dev-gen-html-docs:
	rm -f docs/schemas/*.rst
	./dev/all-schemas-hamsql-setup.py | hamsql doc -s - -o docs/schemas
	rm -r docs/_build
	make -C docs html

dev-gen-docs: dev-gen-html-docs
	make -C docs man
	make -C docs latex
	make -C docs/_build/latex
