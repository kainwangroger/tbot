# Qrgram

Qrgram is a Telegram bot that generates QR codes from user input. Simply send a text message to the bot, and it will return a QR code image.

## Features

- Generate QR codes from text input
- Asynchronous processing
- Animated loader while generating QR codes
- Error handling with user feedback

## Requirements

- Python 3.12
- `python-telegram-bot` library
- `qrcode` library
- `python-dotenv` library
- `image` library

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/htagcours/tbot.git
    cd tbot
    ```

2. Build the Docker image:
    ```sh
    docker build -t hervlokossou/allmight_bot .
    ```

3. Run the Docker container:
    ```sh
    docker run -d --name tele-qr-bot tele-qr
    ```

## Usage

1. Start the bot by running the Docker container as shown above.
2. Open Telegram and search for your bot.
3. Send a text message to the bot.
4. The bot will generate a QR code and send it back to you.

## Contributing

We welcome contributions! Please open an issue or submit a pull request on GitHub.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Acknowledgements

- [python-telegram-bot](https://github.com/python-telegram-bot/python-telegram-bot)
- [qrcode](https://github.com/lincolnloop/python-qrcode)