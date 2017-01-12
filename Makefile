dev-gen-docs:
	rm -f docs/schemas/*.rst
	./dev/all-schemas-hamsql-setup.py | hamsql doc -s - -o docs/schemas
	rm -r docs/_build
	make -C docs html
	make -C docs latex
	make -C docs/_build/latex
