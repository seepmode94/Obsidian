
***crm.seepmode.com is a mixture between both SuiteCRM since it was downgrade from suitecrm8.3.1 into SuiteCRM 7.3***

# Differences Between SuiteCRM 7 and SuiteCRM 8 - Front-End Structure and Customization

## 1. Front-end Architecture:
- **SuiteCRM 7:**
  - The front end is based on **traditional server-side rendering** using PHP and Smarty templates.
  - The user interface is tightly coupled with the back end. Changes to the UI require modifying both PHP and Smarty template files directly.
  - The structure follows a classic monolithic framework where most of the front end logic is embedded into the backend code, making it less modular.

- **SuiteCRM 8:**
  - SuiteCRM 8 introduces a **modern front-end architecture** using **Angular** for the client-side (SPA - Single Page Application).
  - The front end is now decoupled from the back end via a **REST API**. The Angular app interacts with the back-end APIs for data and operations.
  - This modular architecture allows for easier UI updates, better scalability, and the ability to integrate with other front-end technologies or frameworks.
  - SuiteCRM 8's front end is more in line with modern web development practices, using client-side rendering and component-based architecture.

## 2. Customizability and Flexibility:
- **SuiteCRM 7:**
  - Customizations typically involve editing core files like the PHP and Smarty templates.
  - While possible, front-end changes can become complicated, as it’s easy to break the UI or introduce regressions due to the tightly coupled nature of the codebase.
  - The lack of a well-defined API for front-end changes makes it harder to implement updates or improvements without impacting core functionality.

- **SuiteCRM 8:**
  - SuiteCRM 8 is designed with **separation of concerns**, making it easier to modify the front end without disrupting the back end.
  - The Angular-based front end is more flexible and maintainable, allowing developers to create or extend components, styles, and interactions with less risk of breaking core functionality.
  - SuiteCRM 8 leverages the **REST API**, which provides a more robust mechanism to extend functionality without altering the underlying business logic.
  - Front-end developers can work with Angular, which is a modern, widely adopted framework, enabling easier onboarding and faster development cycles.

## 3. Front-end Workflow and Tools:
- **SuiteCRM 7:**
  - Development and changes typically follow a traditional workflow, where front-end developers work closely with PHP developers.
  - Testing and building the front end are more manual processes due to the absence of modern front-end build tools.

- **SuiteCRM 8:**
  - SuiteCRM 8 adopts modern JavaScript development practices, including tools like **Angular CLI**, **Webpack**, and **Yarn**, allowing for more sophisticated workflows.
  - Front-end developers can build, test, and deploy changes using modern tooling, resulting in better performance and maintainability.

## 4. Mobile and Responsiveness:
- **SuiteCRM 7:**
  - SuiteCRM 7 relies on traditional responsive web design practices but doesn't fully leverage modern JavaScript frameworks for a mobile-friendly experience.

- **SuiteCRM 8:**
  - With Angular as the front end, SuiteCRM 8 is inherently better suited for responsive and mobile-friendly design, providing a more seamless experience across different devices.

---

### Summary:
SuiteCRM 8 is far more modular, modern, and developer-friendly when it comes to front-end structure and customization. The decoupled architecture, use of Angular, and REST API make it a more flexible and scalable platform compared to SuiteCRM 7's tightly coupled and traditional server-rendered approach.