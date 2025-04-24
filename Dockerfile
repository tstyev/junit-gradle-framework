FROM gradle:8.10-jdk17-alpine

RUN apk add --no-cache chromium chromium-chromedriver bash curl tar

ENV ALLURE_VERSION=2.32.0

RUN curl -Lo allure.tgz https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.tgz && \
    tar -zxvf allure.tgz -C /opt/ && \
    ln -s /opt/allure-${ALLURE_VERSION}/bin/allure /usr/bin/allure && \
    rm allure.tgz

WORKDIR /app
COPY . .

ENV TARGET_URL="https://test.npgw.xyz/"
ENV CHROME_OPTIONS="--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-allow-origins=*"
ENV TEST_TAGS="test"

ENV TARGET_URL="https://test.npgw.xyz/"
ENV CHROME_OPTIONS="--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-allow-origins=*"
ENV TEST_TAGS="test"

CMD ["sh", "-c", "gradle clean test --no-daemon -DTARGET_URL=\"$TARGET_URL\" -DCHROME_OPTIONS=\"$CHROME_OPTIONS\" \
 && allure generate build/allure-results -o build/allure-report"]


