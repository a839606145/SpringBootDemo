package root.controller.hello;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/*
@RestController
@EnableAutoConfiguration
@ComponentScan
*/
//@SpringBootApplication
@RestController
@RequestMapping("/hello")
public class HelloWorldController {

	@RequestMapping("/hello")
    public String index() {
        return "Hello World";
    }
	
}
