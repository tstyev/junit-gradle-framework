FROM gradle:8.10-jdk17-alpine

RUN apk add --no-cache chromium chromium-chromedriver bash curl tar

WORKDIR /app
COPY . .

ENV TARGET_URL="https://test.npgw.xyz/"
ENV CHROME_OPTIONS="--headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-allow-origins=*"
ENV TEST_TAGS="test"

CMD ["sh", "-c", "./gradlew clean test -DTARGET_URL=\"$TARGET_URL\" -DCHROME_OPTIONS=\"$CHROME_OPTIONS\""]


