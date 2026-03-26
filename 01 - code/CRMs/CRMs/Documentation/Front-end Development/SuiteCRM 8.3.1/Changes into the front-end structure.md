
This guide will help you set up the front-end of your SuiteCRM and understand its structure. The steps here are designed for a CRM that has both SuiteCRM 7.x elements and SuiteCRM 8.x, as your system was downgraded from SuiteCRM 8.x.

SuiteCRM 8.x uses a more modular architecture for the front-end, unlike SuiteCRM 7.x, which relied heavily on server-side rendering (PHP and Smarty templates). This document explains how to set up and modify the front-end in a production environment.

https://docs.suitecrm.com/8.x/developer/installation-guide/8.2.0-front-end-installation-guide/

---

## 1. **System Requirements**

Before setting up the front-end, ensure that the following tools are installed:

- **Node.js** (>=14.x for compatibility)
- **npm** or **yarn** (dependency management)
- **Angular CLI** (for building the front-end)

To verify the installation of these dependencies, run:

```sh
node -v
yarn -v
ng --version
```

Ensure they are:

```sh
node version: v18.20.4
yarn version: 1.22.22
ng version: 12.2.17
```


Make sure you are using _Node.js version 14_ for compatibility with SuiteCRM 8.x's Angular setup.


## 2 **Clean cache/node_modules and legacy open-ssl**

```sh
sudo rm -r cache/*
sudo rm -r public/legacy/cache/*
sudo rm -r node_modules
```


## 3. **Install Dependencies**

Navigate to your SuiteCRM root folder and install the necessary Node.js dependencies using:

```sh
yarn install
```

```sh
export NODE_OPTIONS=--openssl-legacy-provider
```


This will install all required packages for the front-end modules, such as **Angular**, **RxJS**, and others specified in `package.json`

## 4. Compile the dist folder (Not required)

```sh
yarn run build dev
```




## 5. **Build Front-End Packages**

SuiteCRM 8's front-end is divided into several packages that need to be built. The main ones include **common**, **core**, and **shell**.

To build for production, use the following commands:


```sh
yarn run build:common
yarn run build:core
yarn run build:shell
```

**Note:** Build each package in sequence to avoid dependency errors.
yarn run build:common
yarn run build:core
yarn run build:shell
## 5. **Understanding the Front-End Structure**

SuiteCRM 8.x’s front-end is built using **Angular** and is structured in a modular way. The key directories include:

```sh
suitecrm/
├── core/
│   ├── app/
│   │   └── core/   # Core functionality
│   └── services/   # Services used across modules
├── public/
│   └── dist/       # Compiled front-end files
├── shell/          # Angular shell application
│   └── src/        # Source files for the front-end shell
│       ├── app/    # Core components of the UI
│       ├── assets/ # Static assets
│       └── environments/
└── node_modules/   # Installed dependencies
```

### **Key Folders Explained:**

- **core/**: Contains the business logic and shared services used across the application.
- **public/dist/**: The compiled output after building the Angular front-end (used in production).
- **shell/src/**: Contains the entry point for the Angular application (main UI and components).


## 5. **Making Changes and Deploying Them**

When you make changes to any of the `.ts` (TypeScript) files inside the `core/app/` or `shell/src/app/` directories, you must ensure that these changes are compiled properly and are reflected in production.

### Build for Production

To deploy the changes to production, run:

```sh
yarn run build:common
yarn run build:core
yarn run build:shell
```



## 6. **Deploying to Production**

After building the front-end, the compiled files will be in the `public/dist/` directory. You can now deploy these files to your server by copying this folder to your production environment.

Make sure to restart the necessary services to apply the changes to your live system.


## 7. **Troubleshooting**

### Common Issues:

1. **Missing Dependencies**: If a build fails due to missing dependencies, run `yarn install` again to ensure all packages are up-to-date.
2. **Version Mismatches**: Ensure you're using compatible versions of Node, Angular, and other libraries. You can check the required versions in the `package.json` file.