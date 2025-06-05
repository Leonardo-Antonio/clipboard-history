import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GdkPixbuf
import signal
from .read import get_history
from functools import partial
from pyperclip import paste, copy
from pyautogui import hotkey
from os import getenv
import subprocess

class TrayIcon:
    def __init__(self):
        self.icon = Gtk.StatusIcon()
        pixbuf = GdkPixbuf.Pixbuf.new_from_file("assets/icon.svg")
        self.icon.set_from_pixbuf(pixbuf)
        self.icon.set_tooltip_text("Historial de clipboard")
        self.icon.set_visible(True)

        self.icon.connect("popup-menu", self.on_right_click)

    def on_right_click(self, icon, button, time):
        menu = Gtk.Menu()

        for item in get_history():
            label = item["content"][:10]+"..." if len(item["content"]) > 10 else item["content"]
            open_item = Gtk.MenuItem(label=label)
            open_item.connect("activate", partial(self.on_paste, item=item))
            menu.append(open_item)
            
        quit_item = Gtk.MenuItem(label="Salir")
        quit_item.connect("activate", self.on_quit)
        menu.append(quit_item)

        menu.show_all()
        menu.popup(None, None, None, None, button, time)

    def on_paste(self, widget, item):
        copy(item["content"]) 
        if int(getenv("AUTO_EXEC_PASTE"), 0) >= 1:
            paste()
            hotkey('ctrl', 'v')

    def on_quit(self, widget):
        subprocess.run(["sh", "kill.sh"])
        Gtk.main_quit()

        
def run():
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    TrayIcon()
    Gtk.main()