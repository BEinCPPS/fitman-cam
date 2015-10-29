package msee.sp3.cm.fiware.marketplaceri.client.exception;

/**
 * AuthenticationException may occur while trying to obtain a session with a FI-WARE Marketplace RI instance.
 */
public class AuthenticationException extends Exception {

    public AuthenticationException() {
    }

    public AuthenticationException(String message) {
        super(message);
    }
}
