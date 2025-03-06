FROM ubuntu:22.04

RUN apt update
RUN apt upgrade -y
RUN apt install -y tzdata

RUN apt install -y fonts-noto

# python関連パッケージとビルド依存関係をインストール
RUN apt install -y python3-pip python3-cffi python3-brotli libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0 python3-venv python3-full \
    python3-dev gcc libjpeg-dev zlib1g-dev libffi-dev
# 仮想環境の作成とpoetryのインストール
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install poetry

# プロジェクトの依存関係をインストール
WORKDIR /work
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-root

CMD bash
