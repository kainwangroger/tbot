.phony = help install serve-dev

venv:
	@echo "Creating virtual environment..."
	python3 -m venv .venv

install:
	@echo "Installing dependencies..."
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install -r requirements.txt

build:
	@echo "Building the project..."
	docker build  --no-cache -t rogerboukar07/kainwang_bot:latest .

# check-quality:
# 	@echo "Checking code quality..."
# 	sonar-scanner -Dsonar.projectKey=hervlokossou -Dsonar.sources=. -Dsonar.host.url=http://15.237.5.155:9000 -Dsonar.token=sqp_a28f8acd0eebb9a1238e977054361e2620414410

make deploy:
	@echo "Deploying the project..."
	chmod +x deploy.sh
	./deploy.sh
	docker run -d -p 8007:80 rogerboukar07/kainwang_bot

serve:
	@echo "Starting development server..."
	.venv/bin/fastapi dev src/main.py

test:
	@echo "Running tests..."
	.venv/bin/pytest
