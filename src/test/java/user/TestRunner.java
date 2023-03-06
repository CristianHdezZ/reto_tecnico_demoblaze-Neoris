package user;


import com.intuit.karate.junit5.Karate;

public class TestRunner {
    @Karate.Test
    Karate test_API(){
        return Karate.run().relativeTo(getClass());
    }
}
