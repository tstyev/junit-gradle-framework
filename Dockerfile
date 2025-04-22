FROM gradle:8.10-jdk17

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    unzip \
    gnupg \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libvulkan1 \
    libx11-6 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*


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

#
#RUN apt-get update -y && \
#    apt-get install -y --no-install-recommends \
#    ca-certificates \
#    wget \
#    unzip \
#    gnupg \
#    fonts-liberation \
#    libasound2 \
#    libatk-bridge2.0-0 \
#    libatk1.0-0 \
#    libatspi2.0-0 \
#    libcairo2 \
#    libcups2 \
#    libdbus-1-3 \
#    libgbm1 \
#    libglib2.0-0 \
#    libgtk-3-0 \
#    libnspr4 \
#    libnss3 \
#    libpango-1.0-0 \
#    libvulkan1 \
#    libx11-6 \
#    libxcb1 \
#    libxcomposite1 \
#    libxdamage1 \
#    libxext6 \
#    libxfixes3 \
#    libxkbcommon0 \
#    libxrandr2 \
#    xdg-utils \
#    --no-install-recommends && \
#    rm -rf /var/lib/apt/lists/*
#
#RUN curl -LO  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#RUN apt-get install -y ./google-chrome-stable_current_amd64.deb
#RUN rm google-chrome-stable_current_amd64.deb
#
#RUN CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+') && \
#    CHROMEDRIVER_VERSION=$(curl -sS "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VERSION}") && \
#    curl -sS -o /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" && \
#    unzip /tmp/chromedriver.zip -d /usr/local/bin && \
#    chmod +x /usr/local/bin/chromedriver && \
#    rm /tmp/chromedriver.zip

WORKDIR /app
COPY . .

CMD ["sh", "-c", "gradle clean $TEST_TAGS -DTARGET_URL=$TARGET_URL -DCHROME_OPTIONS=\"$CHROME_OPTIONS --user-data-dir=/tmp/chrome-user-data\""]