FROM python:3.12-slim

LABEL MAINTAINER=EsgisDevopsTeam

# set a directory for the app
WORKDIR /code

# copy all the files to the container
COPY ./src /code/app
COPY ./requirements.txt /code/requirements.txt
COPY ./.env /code

# Create folder for QR codes
RUN mkdir -p /code/qrs

# install app-specific dependencies
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
RUN pip install python-telegram-bot[job-queue]

# app command
CMD ["python", "-u", "app/main.py"]