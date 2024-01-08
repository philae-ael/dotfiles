import sys


__print = print


class utils:
    reset = '\033[0m'


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
    c = kwargs.pop("colors", [])

    if not isinstance(c, list):
        c = list(c)

    args = list(args) + [utils.reset]

    if "file" in kwargs:
        __print(*c, sep='', end='', file=kwargs["file"])
    else:
        __print(*c, sep='', end='')
    __print(*args, **kwargs)


def print_rainbow(*args, **kwargs):
    import random
    print(*args, **kwargs, colors=random.choices(print_rainbow.color_list))


print_rainbow.color_list = [c for i, c in fg.__dict__.items() if not i.startswith('_')]
