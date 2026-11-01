FROM debian:trixie-slim@sha256:f6b08b09a05725f9431502d3b5714f5c4576e82c1a84fa1debe0c24a7e0c3ec4 AS builder

# Install full distribution, remove offline documentation, and remove GUI launcher
ADD https://download.racket-lang.org/releases/9.3/installers/racket-9.3-x86_64-linux-buster-cs.sh /tmp/racket-install.sh
RUN sh /tmp/racket-install.sh --create-dir --unix-style --dest /usr/ \
 && rm /tmp/racket-install.sh \
 && rm -rf /usr/share/racket/doc /usr/lib/racket/gracket \
 && find /usr/share/racket/pkgs -maxdepth 1 -type d -name '*-doc' -exec rm -rf {} + \
 && find /usr/lib/racket/compiled -type d -path '*/pkgs/*-doc' -prune -exec rm -rf {} +

FROM debian:trixie-slim@sha256:f6b08b09a05725f9431502d3b5714f5c4576e82c1a84fa1debe0c24a7e0c3ec4 AS runner

RUN apt-get update \
 && apt-get install --yes --no-install-recommends jq \
 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/bin/racket /usr/bin/racket
COPY --from=builder /usr/bin/raco /usr/bin/raco
COPY --from=builder /usr/etc/racket /usr/etc/racket
COPY --from=builder /usr/lib/racket /usr/lib/racket
COPY --from=builder /usr/share/racket /usr/share/racket

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
