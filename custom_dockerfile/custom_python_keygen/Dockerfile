FROM python:3.12 AS build
WORKDIR /app
RUN apt-get update && apt-get install -y  \
    build-essential \
    libssl-dev \
    libffi-dev
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .


FROM python:3.12-slim
WORKDIR /app
COPY --from=build /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=build /app /app

ENTRYPOINT ["python", "main.py"]



