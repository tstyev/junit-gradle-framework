package yev.tst.common.utils;

import io.github.cdimascio.dotenv.Dotenv;
import org.openqa.selenium.chrome.ChromeOptions;

public class ProjectUtils {
    private static final Dotenv dotenv = Dotenv.configure()
            .directory(".")
            .ignoreIfMissing()
            .load();

    public static String getEnv(String key) {
        return System.getProperty(key, dotenv.get(key));
    }

    public static ChromeOptions getChromeOptions(String optionsString) {
        ChromeOptions options = new ChromeOptions();
        if (optionsString != null && !optionsString.isEmpty()) {
            String[] chromeArgs = optionsString.split("\\s+");
            options.addArguments(chromeArgs);
        }
        return options;
    }
}
