#include <X11/Xlib.h>
#include <X11/XKBlib.h>
#include <err.h>
#include <stdlib.h>

int main(void){
        Display *dpy;
        if(!(dpy = XOpenDisplay(0)))
                errx(1, "cannot open display '%s'", XDisplayName(0));
        XkbLockModifiers(dpy, XkbUseCoreKbd, 0xff, 0);
        XSync(dpy, False);
}