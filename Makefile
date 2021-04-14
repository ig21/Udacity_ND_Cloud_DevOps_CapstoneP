## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# nano_app.py should pass pylint
# (Optional) Build a simple integration test


setup:
	# Create python virtualenv & source it
	#apt-get -y install python3-venv
	#sudo yum install -y install python3
	python3 -m venv .devops
	#source .devops/bin/activate
	. .devops/bin/activate

install:
	# This should be run from inside a virtualenv
	#pip3 install --upgrade pip &&\
	#pip3 install -r requirements.txt
	pip3 install --upgrade pip --user &&\
	pip3 install -r requirements.txt --user
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64
	chmod +x /bin/hadolint


test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203 nano_app.py

all: install lint test
