# Docker for Rust

[Dockerfile](https://github.com/ViktorQvarfordt/docker-rust/blob/master/Dockerfile) for compiling rust into lightweight image for production.

The Dockerfile uses the builder-pattern; a multi-staged build where:
1. The first step uses [`rust`](https://hub.docker.com/_/rust) as base image, a 300+ MB image with all requirements for compiling rust.
2. The second step uses the smallest possible base image [`scratch`](https://hub.docker.com/_/scratch), for running the compiled binary executable.

In this way the resulting Docker image is just a few MB large.

## scratch vs alpine

Most people familiar with Docker know that using alpine as the base image is good for keeping the image size small. However, when we only need to run a binary executable there is no need for alpine. We can use the smallest possible base image scratch, capable only of running a binary executable. All docker images, including alpine, are built on top of scratch.

## musl

musl is a lightweight libc implementation. Just like alpine, scratch uses musl rather than glibc as the C library. Therefore, we must instruct the Rust compiler to produce a binary compatible with musl. This is the reason for the reference to `x86_64-unknown-linux-musl` in the Dockerfile.
