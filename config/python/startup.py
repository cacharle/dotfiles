#!/usr/bin/env python3

import os
import sys
from pathlib import Path


def register_readline():
    import atexit
    try:
        import readline
    except ImportError:
        return

    # Reading the initialization (config) file may not be enough to set a
    # completion key, so we set one first and then read the file.
    readline_doc = getattr(readline, '__doc__', '')
    if readline_doc is not None and 'libedit' in readline_doc:
        readline.parse_and_bind('bind ^I rl_complete')
    else:
        readline.parse_and_bind('tab: complete')

    try:
        readline.read_init_file()
    except OSError:
        # An OSError here could have many causes, but the most likely one
        # is that there's no .inputrc file (or .editrc file in the case of
        # Mac OS X + libedit) in the expected location.  In that case, we
        # want to ignore the exception.
        pass

    if readline.get_current_history_length() == 0:
        # If no history was loaded, default to .python_history.
        # The guard is necessary to avoid doubling history size at
        # each interpreter exit when readline was already configured
        # through a PYTHONSTARTUP hook, see:
        # http://bugs.python.org/issue5845#msg198636
        history = ""
        if "XDG_CACHE_HOME" in os.environ:
            history = Path(os.environ["XDG_CACHE_HOME"]) / "python" / "history"
            history.parent.mkdir(parents=True, exist_ok=True)
        else:
            history = os.path.join(os.path.expanduser('~'),
                                   '.python_history')
        try:
            readline.read_history_file(history)
        except OSError:
            pass

        def write_history():
            try:
                readline.write_history_file(history)
            except OSError:
                # bpo-19891, bpo-41193: Home directory does not exist
                # or is not writable, or the filesystem is read-only.
                pass

        atexit.register(write_history)


sys.__interactivehook__ = register_readline

# sys.ps1 = "> "
# sys.ps2 = ". "
