FROM debian:trixie-slim@sha256:109e2c65005bf160609e4ba6acf7783752f8502ad218e298253428690b9eaa4b

ADD https://download.racket-lang.org/releases/9.2/installers/racket-minimal-9.2-x86_64-linux-buster-cs.sh /tmp/racket-install.sh
RUN apt-get update && apt-get install --yes --no-install-recommends jq ca-certificates
RUN sh /tmp/racket-install.sh --create-dir --unix-style --dest /usr/ && rm /tmp/racket-install.sh
RUN raco pkg install zo-lib testing-util-lib rackunit-lib scheme-lib compiler-lib

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
