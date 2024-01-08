import sys


__print = print


class utils:
    reset = '\033[0m'

class bg:
    black = '\033[40m'
    red = '\033[41m'
    green = '\033[42m'
    orange = '\033[43m'
    blue = '\033[44m'
    purple = '\033[45m'
    cyan = '\033[46m'
    lightgrey = '\033[47m'
    darkgrey = '\033[100m'
    lightred = '\033[101m'
    lightgreen = '\033[102m'
    yellow = '\033[103m'
    lightblue = '\033[104m'
    pink = '\033[105m'
    lightcyan = '\033[106m'

class fg:
    black = '\033[30m'
    red = '\033[31m'
    green = '\033[32m'
    orange = '\033[33m'
    blue = '\033[34m'
    purple = '\033[35m'
    cyan = '\033[36m'
    lightgrey = '\033[37m'
    darkgrey = '\033[90m'
    lightred = '\033[91m'
    lightgreen = '\033[92m'
    yellow = '\033[93m'
    lightblue = '\033[94m'
    pink = '\033[95m'
    lightcyan = '\033[96m'


def print_err(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


def print(*args, **kwargs):
    f = kwargs.pop("fg", "")
    b = kwargs.pop("bg", "")

    args = list(args)
    args[-1] = args[-1] + utils.reset

    if "file" in kwargs:
        __print(f, b, sep='', end='', file=kwargs["file"])
    else:
        __print(f, b, sep='', end='')
    __print(*args, **kwargs)


def print_rainbow(*args, **kwargs):
    import random
    print(*args, **kwargs, fg=random.choices(print_rainbow.color_list)[0])


print_rainbow.color_list = [c for i, c in fg.__dict__.items() if not i.startswith('_')]
