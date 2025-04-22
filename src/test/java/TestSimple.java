import org.junit.jupiter.api.Tag;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestSimple {

    @Test
    @Tag("Smoke")
    void test() {
        assertEquals(1,1);
    }
}
