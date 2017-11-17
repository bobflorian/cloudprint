FROM debian:jessie
MAINTAINER Matt OConnell <moconnell@66feet.com>

# Install cups
RUN apt-get update && apt-get install -y \
    cups \
    cups-pdf \
    whois

# Some clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up CUPS
ADD etc-cups /etc/cups
VOLUME /etc/cups/
VOLUME /var/log/cups
VOLUME /var/spool/cups
VOLUME /var/cache/cups

# add dir where s3 mount will go
RUN mkdir /var/spool/cups-pdf/REVEAL
RUN chown nobody:nogroup /var/spool/cups-pdf/REVEAL

EXPOSE 631

ADD start_cups.sh /root/start_cups.sh
RUN chmod +x /root/start_cups.sh
CMD ["/root/start_cups.sh"]
