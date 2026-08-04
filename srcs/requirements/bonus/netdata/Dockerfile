FROM debian:bookworm

RUN apt update && \
    apt install -y curl bash

COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]