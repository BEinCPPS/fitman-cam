package it.eng.sso.lsa.components;

/**
 * Thrown when uid cannot be located in users authentication backend.
 */
public class UserNotFoundException extends Exception {

    /**
	 * 
	 */
	private static final long serialVersionUID = 2225605380633905915L;

	public UserNotFoundException() {
    }

    public UserNotFoundException(String message) {
        super(message);
    }

    public UserNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }

    public UserNotFoundException(Throwable cause) {
        super(cause);
    }
}
