package it.antonioscatoloni.controller;

import it.antonioscatoloni.service.UserService;
import spark.Request;
import spark.Response;
import spark.Route;

import static spark.Spark.*;

/**
 * Created by ascatox on 23/11/16.
 */
public class UserController {
    public UserController(final UserService userService) {

        get("/users", new Route() {
            public Object handle(Request request, Response response) {
                // process request
                return userService.getAllUsers();
            }
        });

    //Add Routes


    }

}
