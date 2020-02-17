#from runipy.notebook_runner import NotebookRunner
#from nbformat import write
#from nbformat import read
import nbformat
from nbconvert.preprocessors import ExecutePreprocessor
from nbconvert.preprocessors import CellExecutionError
#from IPython.nbformat.current import write
#from IPython.nbformat.current import read
from glob import glob

files = glob("./[01]*ipynb")

#with open(notebook_filename) as f:
#    nb = nbformat.read(f, as_version=4)
ep = ExecutePreprocessor(timeout=600, kernel_name='python3')
#ep.preprocess(nb, {'metadata': {'path': 'notebooks/'}})
#with open('executed_notebook.ipynb', 'w', encoding='utf-8') as f:
#    nbformat.write(nb, f)

for file in files:
    with open(notebook_filename) as f:
        nb = nbformat.read(f, as_version=4)
    #print("Processing file {}".format(file))
    #notebook = read(open(file), 'json')
    #r = ep(notebook)
    #r.run_notebook(skip_exceptions=True)
#    nbformat.current import write
    #write(r.nb, open("_runipy/"+file, 'w'), 'json')
    #print("Done file {}".format(file))
    with open(notebook_filename_out, mode='w', encoding='utf-8') as f:
        nbformat.write(nb, f)

try:
    out = ep.preprocess(nb, {'metadata': {'path': run_path}})
except CellExecutionError:
    out = None
    msg = 'Error executing the notebook "%s".\n\n' % notebook_filename
    msg += 'See notebook "%s" for the traceback.' % notebook_filename_out
    print(msg)
    raise

    
