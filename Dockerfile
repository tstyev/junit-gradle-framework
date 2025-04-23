FROM gradle:8.10-jdk17 AS builder

WORKDIR /app
COPY . .

#RUN gradle dependencies --no-daemon

FROM selenium/standalone-chrome:135.0-chromedriver-135.0

USER root

# Обновляем и устанавливаем нужные пакеты
RUN apt-get update && \
    apt-get install -y wget unzip curl ca-certificates && \
    apt-get clean

RUN wget https://services.gradle.org/distributions/gradle-8.10-bin.zip -P /tmp && \
    unzip /tmp/gradle-8.10-bin.zip -d /opt && \
    ln -s /opt/gradle-8.10/bin/gradle /usr/local/bin/gradle

WORKDIR /app
COPY --from=builder /app /app

#RUN mkdir -p /app/build && chmod -R 777 /app/build
#
## Очистить каталог build перед выполнением задач
#RUN rm -rf /app/build/*

ENV TARGET_URL="https://test.npgw.xyz/"
ENV CHROME_OPTIONS="--headless --no-sandbox --disable-dev-shm-usage"
ENV TEST_TAGS="test"

CMD ["sh", "-c", "gradle  $TEST_TAGS --no-daemon -DTARGET_URL=\"$TARGET_URL\" -DCHROME_OPTIONS=\"$CHROME_OPTIONS\""]


