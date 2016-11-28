package it.antonioscatoloni.model;

import java.util.ArrayList;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


public class UserManager {
	
    private ArrayList<User> users;
    
    
	public UserManager () {
		
	}	
        
    public UserManager (JSONOb json) {

        this.users = new ArrayList<User>();
        JSONArray arrayUsers = json.optJSONArray("users");
        if (null != arrayUsers) {
            int usersLength = arrayUsers.length();
            for (int i = 0; i < usersLength; i++) {
                JSONObject item = arrayUsers.optJSONObject(i);
                if (null != item) {
                    this.users.add(new User(item));
                }
            }
        }
        else {
            JSONObject item = json.optJSONObject("users");
            if (null != item) {
                this.users.add(new User(item));
            }
        }


    }
    
    public ArrayList<User> getUsers() {
        return this.users;
    }

    public void setUsers(ArrayList<User> users) {
        this.users = users;
    }


    
}
