import qrcode, os


def generate_qr(chat_id, user_input):
    """
    The function generates a QR code image and saves it to be returned to the user.
    Args:
        chat_id: unique identification for user
        user_input: user string to generate QR with
    """
    print("Generating QR Code for user input: {}".format(user_input))
    img = qrcode.make(user_input)
    img_path = "/code/qrs"
    img.save( '{}/{}.png'.format(img_path, chat_id))
    return None