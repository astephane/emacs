#! C:/Program Files/Git/bin/bash.exe

# echo "Using custom '$0'"
# echo "INSIDE_EMACS: '${INSIDE_EMACS}'"

# Enabled job control.
set -m

# export HOME_DIR=/d/${HOMEPATH}
# export USER=${USERNAME}

if [ -n "$INSIDE_EMACS" ]; then
    export PS1='\[\033[32m\]\u@\h \[\033[35m\]\[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '
fi

# cd ${HOME_DIR}
