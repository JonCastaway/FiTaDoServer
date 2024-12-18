from rust:latest

# Create required directories
RUN mkdir /app /config
WORKDIR /app

# Install required packages
RUN apt update
RUN apt install -y python3-virtualenv python3-pip default-mysql-client

# Clone Mozilla's syncstorage-rs then build it
RUN git clone https://github.com/mozilla-services/syncstorage-rs ./
RUN cargo install --path ./syncserver --no-default-features --features=syncstorage-db/mysql --locked
RUN cargo install diesel_cli --no-default-features --features 'mysql'

# Setup the Python venv
RUN virtualenv venv
RUN /app/venv/bin/pip install -r requirements.txt
RUN /app/venv/bin/pip install -r tools/tokenserver/requirements.txt
RUN /app/venv/bin/pip install pyopenssl==22.1.0

# Cleanup
RUN rm -rf /var/lib/{apt,dpkg,cache,log}

# Copy entrypoint script and set it
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
