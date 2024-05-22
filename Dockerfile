FROM racket/racket:8.13

RUN apt-get install -y jq
RUN raco pkg install zo-lib testing-util-lib rackunit-lib scheme-lib compiler-lib

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
