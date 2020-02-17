from runipy.notebook_runner import NotebookRunner
#from nbformat import write
#from nbformat import read
from IPython.nbformat.current import write
from IPython.nbformat.current import read
from glob import glob

files = glob("./[01]*ipynb")

for file in files:
    print("Processing file {}".format(file))
    notebook = read(open(file), 'json')
    r = NotebookRunner(notebook)
    r.run_notebook(skip_exceptions=True)
#    nbformat.current import write
    write(r.nb, open("_runipy/"+file, 'w'), 'json')
    print("Done file {}".format(file))
