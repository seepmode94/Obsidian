
### System Files

```
core/backend/Navbar/LegacyHandler/NavbarHandler.php
core/backend/Routes/LegacyHandler/RouteConverterHandler.php
config/services/module/module_routing.yaml
extensions/default/config/services/module/module_routing.php
```


### Keep Angular Filters always open

```
core/app/core/src/lib/containers/list-filter/store/list-filter/list-filter.store.ts
core/app/core/src/lib/views/list/components/settings-menu/settings-menu.component.ts
```



### Mass Update for certain data types

```
public/legacy/include/MassUpdate.php
public/legacy/modules/DynamicFields/templates/Fields/Forms/text.tpl
public/legacy/modules/DynamicFields/templates/Fields/Forms/varchar.tpl
public/legacy/modules/DynamicFields/templates/Fields/Forms/relate.tpl
```

## Some users are being redirected to wizard action after login

```sh
public/legacy/modules/UserPreferences/UserPreference.php
```

### Global Search

```
public/legacy/include/Smarty/plugins/function.getFieldValue.php
public/legacy/lib/Search/UI/templates/search.results.tpl
public/legacy/lib/Search/SearchModules.php
```

### Google Sync

```
public/legacy/include/GoogleSync/GoogleSyncBase.php
```


### Activity subpanel can't be sorted by date_due/date_end

```
public/legacy/modules/Accounts/metadata/subpaneldefs.php
public/legacy/modules/Calls/metadata/subpanels/ForActivities.php
public/legacy/modules/Calls/metadata/subpanels/ForHistory.php
public/legacy/modules/Contacts/metadata/subpaneldefs.php
public/legacy/modules/Meetings/metadata/subpanels/ForActivities.php
public/legacy/modules/Meetings/metadata/subpanels/ForHistory.php
```


### Add invoice by email functionality

```
public/legacy/modules/AOS_PDF_Templates/generatePdf.php
public/legacy/modules/AOS_PDF_Templates/sendEmail.php
public/legacy/modules/Emails/Email.php
public/legacy/modules/Emails/include/ComposeView/ComposeView.php
public/legacy/modules/Emails/include/ComposeView/ComposeView.tpl
public/legacy/modules/Emails/include/ComposeView/EmailsComposeView.js
public/legacy/modules/AOS_Invoices/views/view.detail.php
```

### Allow to send emails from different domains in workflow

```
public/legacy/modules/AOW_Actions/actions/actionSendEmail.php
public/legacy/modules/AOW_Actions/actions/actionSendEmail.js
public/legacy/modules/AOW_WorkFlow/AOW_WorkFlow.php
public/legacy/modules/AOW_WorkFlow/controller.php
```


### Remove limit of columns and data format inside the table

```
core/app/core/src/lib/components/table/table-body/table-body.component.ts
```


### Added Not_Starts_With condition on workflows

```
public/legacy/modules/AOW_WorkFlow/AOW_WorkFlow.php
public/legacy/modules/AOW_WorkFlow/controller.php
public/legacy/include/language/pt_PT.lang.php
```

### Primavera Update

```
public/legacy/modules/AOS_Quotes/converToInvoice.php
public/legacy/modules/AOS_Quotes/createContract.php
public/primavera_scripts
```

### Schedulers

```
public/legacy/modules/Schedulers/_AddJobsHere.php
```


### Custom Folders

```sh
public/legacy/contract_links/
public/media
```

### Compiler Files

```
tsconfig.json
```

### Allow billing_address_country be displayed in list - 17/10/2024

```sh
core/app/core/src/lib/store/metadata/metadata.store.spec.mock.ts
core/app/core/src/lib/views/record/store/record-view/record-view.store.spec.mock.ts
```

### Cancel button starts redirecting to own record page - 03/06/2025

```sh
public/legacy/include/Smarty/plugins/function.sugar_button.php
```



## Notas

You need to add this in .env or else you will not be able to login

```sh
APP_SECRET=61fa55921f28d35513c235afde5f9e5d3a43450555fcf09a27bf8b677eaa21ba
```


- [x] Corrigir Report Legacy
- [ ] Verificar Pdfs
- [ ] Verificar assinaturas no SST
- [ ] Verificar Cronjobs
- [ ] Verificar Filtros

### Features que devem ser confirmadas pós upgrade

- [ ] Modificações na impressão para PDF das fichas de Aptidão
- [ ] Barcodes na medicina ocupacional (media/barcodes)
- [ ] Criar Campo para assinatura digital
- [ ] Botões de editar no final da página
- [ ] Coluna "Concelho" e "Numero de telefone" na tabela das assistências
- [ ] Correção da password não ficar guardada no outbound emails
- [ ] Campo descrição aparece desformatado nas tabelas
- [ ] Limite no número de colunas que se pode visiolizar nas tabelas
- [ ] Atualização em massa não funcionava para certo tipo de campos
- [ ] Permitir o envio de emails a partir de diferentes remetentes
- [ ] Permitir enviar emails a partir de emails com um dominio diferente ao do sistema
- [ ] Corrigir Pesquisa Global para alguns modulos
- [ ] Os templates dos PDFs aparecerem por ordem na vista de pop up
- [ ] Integração do Primavera
- [ ] Conversão automática de fatura em Formação e assistência
- [ ] Confirmar a correta formatação dos nomes dos calendários