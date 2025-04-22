package yev.tst.run;

import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;
import yev.tst.common.BaseTest;


public class TestSimple extends BaseTest {

    @Test
    @Tag("Smoke")
    void test() {
        System.out.println(getDriver().getCurrentUrl());
    }
}
