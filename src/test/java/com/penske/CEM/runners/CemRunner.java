package com.penske.CEM.runners;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.driver.WebDriver;
import core.ExecutionHook;
import core.config.RunConfig;
import org.junit.jupiter.api.*;

public class CemRunner {
    static WebDriver driver;
    /*@BeforeAll
    public static void preConditionsBeforeExecution() {
        Collector.getInstance().removeRerunDir();
    }*/
    @Test
    @Order(1)
    public void SelectedRunner() {
        Runner.Builder rb = Runner.builder();
        rb.path("classpath:com/penske/Coreconnect/scenarios");
        rb.tags("~@Ignore");
        rb.hook(new ExecutionHook()).reportDir("target/Karate-reports/main");
        Results results = rb.outputCucumberJson(true).parallel(RunConfig.getInstance().THREAD_COUNT());
        //Collector.getInstance().getResults(results);
    }

   // @AfterAll
    //public static void postConditionsAfterExecution() {
    //    Collector.getInstance().afterExecution();
  //  }

}