FROM debain:

RUN apt update && apt install mariadb-server

copy script.sh usr/bin/mysql/script.sh

RUN chmod +x usr/bin/mysql/script.sh

CMD ["usr/bin/mysql/script.sh"]
