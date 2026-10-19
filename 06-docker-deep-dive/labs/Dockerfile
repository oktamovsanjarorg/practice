FROM alpine:3.19
RUN adduser -D sanjar && mkdir /app && chown -R sanjar:sanjar /app
USER sanjar
WORKDIR /app
CMD ["sh","-c","echo 'salom,men xavfsiz user: ' && whoami && pwd && id sanjar"]
