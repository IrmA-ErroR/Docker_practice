# Best practices при создании образов для докер-контейнеров

1. Установка только необходимых пакетов в образ

2. Комбинирование нескольких инструкций в одну и очистка временных файлов в этой же инструкции

3. Предотвращение копирования нежелательных файлов в контекст сборки при помощи '.dockerignore'

4. Использовать multi-stage сборки

## Multi-stage builds
Многоэтапные сборки

В двух словах, многоэтапная сборка может переносить артефакты с одного этапа сборки на другой, и каждый этап сборки может быть создан из другого базового образа.

Таким образом, в следующем примере вы собираетесь использовать полномасштабный официальный образ Go для сборки своего приложения. Затем вы скопируете двоичный файл приложения в другой образ, база которого очень скудна и не включает цепочку инструментов Go или другие дополнительные компоненты.

Dockerfile.multistage в репозитории примера приложения имеет следующее содержимое:

```
# syntax=docker/dockerfile:1

# Build the application from source
FROM golang:1.19 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping

# Run the tests in the container
FROM build-stage AS run-test-stage
RUN go test -v ./...

# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /docker-gs-ping /docker-gs-ping

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/docker-gs-ping"]
```
Поскольку у вас теперь два Dockerfile, вам нужно указать Docker, какой Dockerfile вы хотите использовать для сборки образа. Пометьте новый образ тегом multistage. Этот тег (как и любой другой, кроме latest) не имеет особого значения для Docker, это просто то, что вы выбрали.