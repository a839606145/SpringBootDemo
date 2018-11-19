package root.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import root.pojo.User;

@Repository
public interface UserDao extends CrudRepository<User,String>{

	
}
