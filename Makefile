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
	docker build -t rogerboukar07/kainwang_bot .

make deploy:
	@echo "Deploying the project..."
	docker rm -f $(docker ps -a --filter ancestor=rogerboukar07/kainwang_bot --format="{{.ID}}")
	docker run -d -p 8007:80 rogerboukar07/kainwang_bot --name kainwang_bot

serve:
	@echo "Starting development server..."
	.venv/bin/fastapi dev src/main.py

test:
	@echo "Running tests..."
	.venv/bin/pytest