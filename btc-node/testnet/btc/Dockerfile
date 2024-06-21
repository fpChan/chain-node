FROM ubuntu:20.04
ADD https://bitcoincore.org/bin/bitcoin-core-27.0/bitcoin-27.0-x86_64-linux-gnu.tar.gz .
RUN tar -xzvf bitcoin-27.0-x86_64-linux-gnu.tar.gz -C ./
ADD entrypoint.sh ./
ADD bitcoin.conf /etc/bitcoin/bitcoin.conf
user root
RUN chmod 777 ./entrypoint.sh
RUN chmod go-w /etc/bitcoin/bitcoin.conf
RUN mkdir -p /data/bitcoin/bitcoin-data
RUN chown -R 755 /data/bitcoin/bitcoin-data

EXPOSE 18332

ENTRYPOINT ["./entrypoint.sh"]