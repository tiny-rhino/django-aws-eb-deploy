#!/bin/sh -l

echo $python_version
/root/.pyenv/bin/pyenv install $python_version
/root/.pyenv/bin/pyenv global $python_version
/root/.pyenv/bin/pyenv virtualenv $python_version venv
source /root/.pyenv/versions/venv/bin/activate

pip install flake8

# stop the build if there are Python syntax errors or undefined names
flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics

# exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide
flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics