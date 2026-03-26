
Check oauth2-clients module in suitecrm
## Grant Types

### 1. Client Credentials Grant

- **Description**: This flow is used by clients to obtain an access token outside of the context of a user. It is typically used when the client is acting on its own behalf or when the client is accessing resources that are not user-specific.
- **Permissions**: The permissions are generally tied to the client itself and not any specific user. This is useful for server-to-server communication.
- **Use Case**: Suitable for machine-to-machine authentication, such as a client accessing an API that doesn't require user context.

### 2. Password Grant

- **Description**: This flow is used by clients to obtain an access token by using the resource owner's password. It allows the client to exchange the user's username and password for an access token directly.
- **Permissions**: The permissions are tied to the specific user whose credentials are being used. This allows the client to access resources on behalf of the user.
- **Use Case**: Suitable when the client is trusted with the user's credentials, such as in first-party applications (e.g., a mobile app accessing its own backend server).


***All configurations are already setup in Postman***

## Google calendar:  

https://www.youtube.com/watch?v=oS8yaBxJURs

[https://docs.suitecrm.com/admin/administration-panel/google-sync/](https://docs.suitecrm.com/admin/administration-panel/google-sync/)




