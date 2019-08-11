FROM rust as builder

WORKDIR /workdir

COPY . .

RUN rustup target install x86_64-unknown-linux-musl
RUN cargo build --release --target=x86_64-unknown-linux-musl

FROM scratch

COPY --from=builder /workdir/target/x86_64-unknown-linux-musl/release/hello-world /hello-world

ENTRYPOINT ["/hello-world"]
