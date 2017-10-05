import sys
from http.client import HTTPSConnection
from base64 import b64encode
import json
import urllib.parse
import curses

from_cmdline = False
try:
    __file__
    from_cmdline = True
except NameError:
    pass


if not from_cmdline:
    import vim

def sq_escape(s):
    return s.replace("'", "''")


def input(prompt, text='', password=False):
    vim.command('call inputsave()')
    vim.command("let i = %s('%s', '%s')" % (('inputsecret' if password else 'input'),
                                            sq_escape(prompt), sq_escape(text)))
    vim.command('call inputrestore()')
    return vim.eval('i')


def var_exists(var):
    return bool(int(vim.eval("exists('%s')" % sq_escape(var))))


def get_from_config(var):
    if var_exists(var):
        return vim.eval(var)
    return None


def get_from_config_or_prompt(var, prompt, password=False, text=''):
    c = get_from_config(var)
    if c is not None:
        return c
    else:
        resp = input(prompt, text=text, password=password)
        vim.command("let %s = '%s'" % (var, sq_escape(resp)))
        return resp


def base_url():
    return get_from_config_or_prompt('g:codebeamer_editor_url',
                                     "Codebeamer Host, like 'example.org': ")

def rest_prefix():
    return get_from_config_or_prompt('g:codebeamer_rest_prefix',
                                     "Codebeamer REST prefix, like '/cb/rest/': ")

def site_auth():
    user = get_from_config_or_prompt('g:codebeamer_basicauth_username',
                                     'Basic Auth Username: ')
    password = get_from_config_or_prompt('g:codebeamer_basicauth_password',
                                         'Basic Auth Password: ', password=True)
    #we need to base 64 encode it 
    #and then decode it to acsii as python 3 stores it as a byte string
    userAndPass = b64encode((user + ":" + password).encode("utf-8")).decode("ascii")
    return { 'Authorization' : 'Basic %s' %  userAndPass }


def site():
    return HTTPSConnection(base_url())


def infer_default(item_number):
    if not item_number:
        item_number = vim.current.buffer.vars.get('item_number')
    else:
        item_number = item_number[0]

    if not item_number:
        sys.stderr.write('No article specified.\n')

    return item_number


# Commands.

def cb_read(item_number):
    stdcsr = curses.initscr()
    vim.command("new")
    vim.command("cabbrev <buffer> write CBWrite")
    vim.command("cabbrev <buffer> w CBWrite")
    vim.command("filetype off")
    vim.command("filetype on")
    vim.command("let b:item_number = '%s'" % item_number)
    vim.current.buffer.options["swapfile"] = False

    connection = site()
    connection.request('GET', rest_prefix() + "item/" + item_number, headers=site_auth())
    response = connection.getresponse().read().decode("utf-8")
    vim.current.buffer[:] = json.loads(response)["description"].split("\n")
    connection.close()
    vim.current.buffer.options["modified"] = False


def cb_write(item_number):
    item_number = infer_default(item_number).decode('utf-8')

    connection = site()
    connection.request('PUT', rest_prefix() + "item", body=json.dumps({
                                                                        "uri" : ("/item/" + item_number),
                                                                        "description" : "\n".join(vim.current.buffer)
                                                                      }), headers=site_auth())
    connection.close()
    vim.current.buffer.options["modified"] = False
