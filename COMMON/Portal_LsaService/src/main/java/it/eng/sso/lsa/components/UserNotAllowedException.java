package it.eng.sso.lsa.components;

/**
 * Thrown when user exists but is not allowed to login (e.g. has been locked or otherwise deactivated)
 */
public class UserNotAllowedException extends Exception {

    /**
	 * 
	 */
	private static final long serialVersionUID = -6605845005490777590L;

	public UserNotAllowedException() {
    }

    public UserNotAllowedException(String message) {
        super(message);
    }

    public UserNotAllowedException(String message, Throwable cause) {
        super(message, cause);
    }

    public UserNotAllowedException(Throwable cause) {
        super(cause);
    }
}
