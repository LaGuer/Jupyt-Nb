import os
import subprocess
import tempfile


def _exec_notebook(path):
    with tempfile.NamedTemporaryFile(suffix=".ipynb") as fout:
        args = ["jupyter", "nbconvert", "--to", "notebook", "--execute",
                "--ExecutePreprocessor.timeout=1000",
                "--output", fout.name, path]
        subprocess.check_call(args)


def get_temp_file_name():
    ftemp = tempfile.NamedTemporaryFile(suffix=".ipynb")
    temp_file_name = os.path.join(os.getcwd(), os.path.split(ftemp.name)[-1])
    ftemp.close()
    return temp_file_name


def _exec_notebook_win(path):
    temp_file_name = get_temp_file_name()

    args = ["jupyter", "nbconvert", "--to", "notebook", "--execute",
            "--ExecutePreprocessor.timeout=1000",
            "--ExecutePreprocessor.kernel_name=python",
            "--output", temp_file_name, path]

    try:
        subprocess.check_call(args)
    except BaseException as e:
        if os.path.exists(temp_file_name):
            os.remove(temp_file_name)
        raise e

    if os.path.exists(temp_file_name):
        os.remove(temp_file_name)


def test():
    if 'nt' == os.name:
        _exec_notebook_win('test.ipynb')
    else:
        _exec_notebook('test.ipynb')

