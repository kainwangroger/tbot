import os
import threading
import qr as qh
from waiter import show_animated_loader

from telegram.constants import ParseMode

img_path = "/code/qrs"

# ------------------- User input functions ------------------- #
async def show_help(update, context):
    """
    Function to list help commands.
    Args:
        update: default telegram arg
        context: default telegram arg
    """
    await update.message.reply_text("""Simply send a text to generate a QR for it!\n
Have ideas and suggestions for this mini project? Head over to the
<a href="https://github.com/tjtanjin/tele-qr">Project Repository</a>!""", parse_mode=ParseMode.HTML, disable_web_page_preview=True) # noqa
    return None


async def get_input(update, context):
    """
    Function to get input string from user.
    Args:
        update: default telegram arg
        context: default telegram arg
    """
    chat_id = update.message.chat.id
    try:
        processing_msg = await update.message.reply_text("<b>Generating qr code |</b>",
                                                         parse_mode=ParseMode.HTML)
        conversion_process = threading.Thread(target=qh.generate_qr,
                                              args=(chat_id, update.message.text))
        conversion_process.start()
        while conversion_process.is_alive():
            await show_animated_loader(processing_msg)

        await context.bot.send_document(chat_id=chat_id,
                                        document=open('{}/{}.png'.format(img_path, chat_id), 'rb'),
                                        caption="Here is your QR Code!")
        os.remove("{}/{}.png".format(img_path, chat_id))
    except (Exception,):
        await context.bot.send_message(chat_id=chat_id, text='An error has occurred. Please check your code!', parse_mode=ParseMode.HTML, disable_web_page_preview=True) # noqa
    return None