ARG BASE_CONTAINER=jupyter/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Frank LaNasa <fjlanasa@gmail.com>"

RUN conda install -c conda-forge ipython-sql

RUN conda install -c conda-forge pandas

RUN conda install -c conda-forge jupyter_contrib_nbextensions

RUN jupyter nbextension enable toc2/main

RUN jupyter nbextension enable exercise2/main

RUN jupyter labextension install @jupyterlab/toc

COPY ["db.py", "./"]

RUN mkdir feed

RUN python db.py

COPY ["*.ipynb", "./"]

COPY ["img", "./img"]

ENV JUPYTER_ENABLE_LAB=1

CMD ["start-notebook.sh"]