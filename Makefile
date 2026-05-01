report_dir=report/
report_name=main

clean:
	# clean LaTeX artifacts
	@for file_ext in "*.pdf" "*.aux" "*.log" "*.toc" "*.out"; do \
		find $(report_dir) -name "$${file_ext}" -delete; \
	done
	# clean other artifacts
	find . -name "*.compiled.*" -delete; \
	rm -rf target
run: clean
	python src/main/python/main.py
	mvn package
	docker compose --file docker/compose.yml --project-directory . up
down:
	docker compose --file docker/compose.yml --project-directory . down
pdf:
	cd "${report_dir}"; \
	xelatex --shell-escape -interaction=nonstopmode "${report_name}"; \
	xelatex --shell-escape -interaction=nonstopmode "${report_name}"