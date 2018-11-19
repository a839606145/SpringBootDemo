package root.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import root.dao.UserDao;
import root.pojo.User;

@Service
public class UserService {
	@Autowired
	public UserDao userDao;
	public User getUserById(String id){
	  return	userDao.findOne(id);
	}

}
