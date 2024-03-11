# TODO:
# - shouldnt run as root
# - should have mountable directory for additional local notebooks

FROM python:3.12 as python-build

EXPOSE 8888
WORKDIR /playground

# INSTALL SYSTEM DEPENDENCIES
RUN apt-get update \
    && apt-get install --no-install-recommends --assume-yes curl graphviz

# INSTALL POETRY
ENV POETRY_VERSION="1.8.2"
ENV POETRY_HOME="/opt/poetry"
RUN curl -sSL https://install.python-poetry.org | python3 -


# NAIVELY COPY CODE AND INSTALL DEPENDENCIES
COPY . /playground
RUN /opt/poetry/bin/poetry install --only main


WORKDIR /playground/notebooks
ENTRYPOINT [ "/opt/poetry/bin/poetry", "run", "jupyter", "notebook", "--no-browser", "--ip", "0.0.0.0"]
