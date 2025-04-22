FROM maven:3.9.9-eclipse-temurin-17

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    unzip \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

RUN CHROME_MAJOR_VERSION=$(google-chrome --version | awk '{print $3}' | cut -d'.' -f1) && \
    CHROME_FULL_VERSION=$(google-chrome --version | awk '{print $3}') && \
    wget -q -O /tmp/chromedriver.zip \
    "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_FULL_VERSION/linux64/chromedriver-linux64.zip" && \
    unzip /tmp/chromedriver.zip -d /tmp && \
    mv /tmp/chromedriver-linux64/chromedriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm -rf /tmp/chromedriver*

WORKDIR /app
COPY . .

CMD ["sh", "-c", "mvn clean test -DTARGET_URL=$TARGET_URL -DCHROME_OPTIONS=\"$CHROME_OPTIONS\""]