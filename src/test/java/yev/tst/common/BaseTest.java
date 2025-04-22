package yev.tst.common;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import yev.tst.common.utils.ProjectUtils;

@Slf4j
public abstract class BaseTest {
    @Getter
    private WebDriver driver;
    private static String targetUrl;
    private static String chromeOptions;

    @BeforeAll
    public static void beforeClass() {
        targetUrl = ProjectUtils.getEnv("TARGET_URL");
        chromeOptions = ProjectUtils.getEnv("CHROME_OPTIONS");

        log.info("Using TARGET_URL: {}", targetUrl);
        log.info("Using CHROME_OPTIONS: {}", chromeOptions);

        if (targetUrl == null || chromeOptions == null) {
            throw new IllegalArgumentException("TARGET_URL and CHROME_OPTIONS must be set!");
        }
    }

    @BeforeEach
    public void setUp() {
        ChromeOptions options = ProjectUtils.getChromeOptions(chromeOptions);

//        options.setBinary("/usr/bin/google-chrome");
        driver = new ChromeDriver(options);
        driver.get(targetUrl);

        log.info("Browser opened");
    }

    @AfterEach
    public void tearDown() {
        if (driver != null) {
            log.info("Browser closed");
            driver.quit();
        }
    }
}
