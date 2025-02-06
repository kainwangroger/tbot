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
	@echo "Stopping and removing any existing container..."
	@CONTAINER_ID=$$(docker ps -aq --filter "ancestor=rogerboukar07/kainwang_bot") && \
	if [ -n "$$CONTAINER_ID" ]; then \
		docker stop $$CONTAINER_ID; \
		docker rm $$CONTAINER_ID; \
	fi

	@echo "Deploying the project..."
	docker run -d -p 8007:80 --name kainwang_bot rogerboukar07/kainwang_bot

serve:
	@echo "Starting development server..."
	.venv/bin/fastapi dev src/main.py

test:
	@echo "Running tests..."
	.venv/bin/pytest