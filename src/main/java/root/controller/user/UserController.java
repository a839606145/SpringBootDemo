package root.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import root.pojo.User;
import root.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	public UserService userService;
	@RequestMapping("/hello")
	public String hello(Model model){
		User user=userService.getUserById("1");
		model.addAttribute("name", user.getName());
		return "user/user";
	}
	@RequestMapping("/world")
	public ModelAndView world(){
		ModelAndView mv=new ModelAndView("/user/user");
		return mv;
	}

}
