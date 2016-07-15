dev-gen-docs:
	rm -f docs/schemas/*.rst
	hamsql doc -o docs/schemas -s examples/setup.yml
	rm -r docs/_build
	make -C docs html
	make -C docs latex
	make -C docs/_build/latex
