FROM python:3.13-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:0.7.20 /uv /uvx /bin/

ADD . /app

WORKDIR /app/src

RUN uv sync --locked

EXPOSE 8000

CMD ["uv" , "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]