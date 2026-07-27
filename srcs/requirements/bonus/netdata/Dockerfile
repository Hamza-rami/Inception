FROM debian:bullseye

RUN apt update && \
    apt install -y curl bash

COPY script.sh /script.sh
RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]