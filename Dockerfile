FROM rust:latest

# Create required directories
RUN mkdir /app /config
WORKDIR /app

# Install required packages
RUN apt-get update && apt-get install -y \
    python3-virtualenv \
    python3-pip \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Clone Mozilla's syncstorage-rs and build it
RUN git clone https://github.com/mozilla-services/syncstorage-rs ./
RUN cargo install --path ./syncserver --no-default-features --features=syncstorage-db/mysql --locked
RUN cargo install diesel_cli --no-default-features --features 'mysql'

# Setup the Python virtual environment
RUN virtualenv venv
RUN /app/venv/bin/pip install -r requirements.txt
RUN /app/venv/bin/pip install -r tools/tokenserver/requirements.txt
RUN /app/venv/bin/pip install pyopenssl==22.1.0

# Copy stage 1 script and set its permissions
COPY stage1.sh /
RUN chmod +x /stage1.sh

ENTRYPOINT ["/stage1.sh"]
