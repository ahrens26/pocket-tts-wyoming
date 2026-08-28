FROM ghcr.io/astral-sh/uv:debian

WORKDIR /app

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/kyutai-labs/pocket-tts.git .

COPY wyoming_tts_server.py .

ENV UV_TORCH_BACKEND=cpu

RUN uv add "wyoming>=1.8,<2" zeroconf
RUN uv add "torch" --index https://download.pytorch.org/whl/cpu --reinstall
RUN uv sync

ENV WYOMING_PORT=10201
ENV WYOMING_HOST=0.0.0.0
ENV DEFAULT_VOICE=alba
ENV MODEL_VARIANT=english
ENV PYTHONUNBUFFERED=1

EXPOSE 10201

CMD ["uv", "run", "python", "wyoming_tts_server.py"]
