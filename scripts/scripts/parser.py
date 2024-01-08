class Buffer:
    def __init__(self, string):
        self.string = string

    def end(self):
        return len(self.string) == 0

    def match_regex(self, regex, f=lambda x: x):
        r = regex.match(self.string)
        if r is None:
            return None

        matched = self.string[:r.end()]
        self.string = self.string[r.end():]
        return f(matched)

    def match_string(self, string):
        if not self.string.startswith(string):
            return None

        self.string = self.string[len(string):]
        return string
