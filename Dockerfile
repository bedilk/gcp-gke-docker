# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#

# [START gke_quickstarts_hello_app_dockerfile]
FROM golang:1.21.0 as builder
WORKDIR /app
RUN go mod init hello-app
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-app

FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY --from=builder /hello-app /hello-app
ENV PORT 8080
USER nonroot:nonroot
CMD ["/hello-app"]
# [END gke_quickstarts_hello_app_dockerfile]