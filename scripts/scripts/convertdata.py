import argparse
import json
import re


class Converter:
    def __init__(self, *args, **kwargs):
        try:
            self.can_chain
        except AttributeError:
            self.can_chain = False

        self._chain = None

    def setup(self, *args, **kwargs):
        if self._chain:
            self._chain.setup(*args, **kwargs)
        return self

    def __call__(self, str):
        return self.converter(str)

    def chain(self, other):
        if not self.can_chain:
            raise NotImplementedError

        self._chain = other
        return self


class SimpleConverter(Converter):
    def __init__(self, converter_fct, *args, **kwargs):
        self.converter = converter_fct
        super().__init__(*args, **kwargs)


class ListConverter(Converter):

    def __init__(self, *args, **kwargs):
        self.can_chain = True
        super().__init__()

    def setup(self, *args, **kwargs):
        self.sep = kwargs.pop("sep")

        return super().setup(*args, kwargs)

    def __call__(self, str):
        tmp = str.split(self.sep)
        if self._chain is None:
            return tmp

        return list(map(self._chain, tmp))


convert_table_input = {
    "list":
        (ListConverter(),
         ['sep']),
    "listint":
        (ListConverter().chain(SimpleConverter(int)),
         ['sep']),
    "listfloat":
        (ListConverter().chain(SimpleConverter(float)),
         ['sep']),
    "integer":
        (SimpleConverter(int), []),
    "float":
        (SimpleConverter(float), []),
    "json":
        (SimpleConverter(json.loads), []),
    "string":
        (SimpleConverter(lambda x: x), [])
}


def get_converter_list():
    return list(convert_table_input.keys())


def get_converter_options(converter):
    return convert_table_input[converter][1]


def get_converter(convert_type, options):
    return convert_table_input[convert_type][0].setup(**options)


def configure_argparser(parser,
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
        def test_regex(regex, f=None):
            nonlocal opt_str
            r = regex.match(opt_str)
            if r:
                end = r.end()
                i = f(opt_str[:end]) if f else opt_str[:end]
                opt_str = opt_str[end:]
                return i
            return None

        options = {}
        while opt_str:

            n = test_regex(name)
            if not n:
                raise argparse.ArgumentTypeError(
                    "Can't convert convert options - Can't match a name")

            if opt_str[0] != '=':
                raise argparse.ArgumentTypeError(
                    "Can't convert convert options - Can't match a '='")
            opt_str = opt_str[1:]

            i = test_regex(integer, int) or \
                test_regex(string, lambda x: x[1:-1]) or \
                test_regex(rest)

            if not i:
                raise argparse.ArgumentTypeError(
                    "Can't convert convert options - Can't match an integer, \
                    a string or a name")

            options[n] = i

            if opt_str:
                if opt_str[0] != ',':
                    raise argparse.ArgumentTypeError(
                        "Can't convert convert options - Can't match a ','")

        return options

    def make_help():
        return

    group = parser.add_argument_group(group_descr)

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
    parser = argparse.ArgumentParser()
    parser.add_argument("input")

    configure_argparser(parser, True)

    args = parser.parse_args()

    print(get_converter(args.converter, **args.converter_options)(args.input))
