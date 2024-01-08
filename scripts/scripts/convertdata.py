#!/usr/bin/python
import argparse
import json
import re
import functools

import parser

def compose(f, g):
    #  because it's g's interface that is seen
    @functools.wraps(g)
    def wrap(*args, **kwargs):
        return f(g(*args, **kwargs))
    return wrap


class Converter:
    def __init__(self, *args, **kwargs):
        self._chain = []

    def setup(self, *args, **kwargs):
        for c in self._chain:
            if isinstance(c, Converter):
                self.c.setup(*args, **kwargs)
        return self

    def __call__(self, inp):
        chain = getattr(self, "__chain__", lambda f, x: f(x))
        for f in self._chain:
            inp = chain(f, inp)
        return inp

    def chain(self, other):
        self._chain.append(other)
        return self


class SimpleConverter(Converter):
    def __init__(self, converter_fct, *args, **kwargs):
        self.converter = converter_fct
        super().__init__(*args, **kwargs)

    def __call__(self, inp):
        inp = self.converter(inp)
        return super().__call__(inp)


class ListConverter(Converter):
    def setup(self, *args, **kwargs):
        self.sep = kwargs.pop("sep")

        return super().setup(*args, kwargs)

    def __call__(self, str):
        tmp = str.strip().split(self.sep)
        return super().__call__(tmp)

    def __chain__(self, f, inp):
        return list(map(f, inp))


def stripstr(x): return x.strip()


convert_table_input = {
    "list":
        (ListConverter(),
         ['sep']),
    "listint":
        (ListConverter().chain(stripstr).chain(float),
         ['sep']),
    "listfloat":
        (ListConverter().chain(stripstr).chain(float),
         ['sep']),
    "integer":
        (SimpleConverter(stripstr).chain(int), []),
    "float":
        (SimpleConverter(stripstr).chain(float), []),
    "json":
        (SimpleConverter(json.loads), []),
    "string":
        (SimpleConverter(lambda x: x), [])
}

alias = {
    "int": "integer",
    "i": "integer",
    "j": "json",
    "f": "float",
    "s": "string",
    "l": "list",
    "li": "listint",
    "lf": "listfloat",
}


def get_converter_list():
    return list(convert_table_input.keys()) + list(alias.keys())


def get_converter_options(converter):
    if converter in alias:
        converter = alias[converter]
    return convert_table_input[converter][1]


def get_converter(converter, options):
    if converter in alias:
        converter = alias[converter]
    return convert_table_input[converter][0].setup(**options)


def configure_argparser(argparser,
                        default="json",
                        group_descr='Convert input',
                        cnvt_short='-c',
                        cnvt_long='--convert-input',
                        cnvt_dest='converter',
                        opt_short='-o',
                        opt_long='--convert-input-options',
                        opt_dest='converter_options'):

    def make_options_help():
        s = "List of options for converter: "
        for converter in get_converter_list():
            s += f"{converter}:\
                    [{','.join(get_converter_options(converter))}]; "

        s += f"""Note that you have to pass option as in this exemple: {opt_short}
                 a=',',b=5"""
        return s

    name = re.compile("""\w+""")
    string = re.compile("""(?P<quote>['"])((?!\(?P=quote)).*?(?P=quote)""")
    integer = re.compile("""d+""")
    rest = re.compile("""[^,]+""")

    def convert_opt(opt_str):
        buf = parser.Buffer(opt_str)

        options = {}
        while not buf.end():
            n = buf.match_regex(name)
            if not n:
                raise argparse.ArgumentTypeError(
                    "Can't convert convert options - Can't match a name")

            if not buf.match_string("="):
                raise argparse.ArgumentTypeError(
                    "Can't convert convert options - Can't match a '='")

            i = buf.match_regex(integer, int) or \
                buf.match_regex(string, lambda x: x[1:-1]) or \
                buf.match_regex(rest)

            if not i:
                raise argparse.ArgumentTypeError(
                    "Can't convert convert options - Can't match an integer, \
                    a string or a name")

            options[n] = i

            if not buf.end() and not buf.match_string(","):
                raise argparse.ArgumentTypeError(
                    "Can't convert convert options - Can't match a ','")

        return options

    def make_help():
        return

    group = argparser.add_argument_group(group_descr)

    group.add_argument(cnvt_short,
                       cnvt_long,
                       choices=get_converter_list(),
                       dest=cnvt_dest,
                       help=make_help(),
                       default=default)

    group.add_argument(opt_short,
                       opt_long,
                       type=convert_opt,
                       dest=opt_dest,
                       help=make_options_help(),
                       default={})


if __name__ == "__main__":
    argparser = argparse.ArgumentParser()
    argparser.add_argument("input")

    configure_argparser(argparser, True)

    args = argparser.parse_args()

    print(get_converter(args.converter, args.converter_options)(args.input))
