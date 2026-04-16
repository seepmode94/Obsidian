String get _editLabel => _byLanguage(pt: 'Editar', en: 'Edit', es: 'Editar');

String get _registerResignationLabel => _byLanguage(

pt: 'Registar saída',

en: 'Register resignation',

es: 'Registrar salida',

);

String get _resignationRegisteredLabel => _byLanguage(

pt: 'Saída registada com sucesso.',

en: 'Resignation registered successfully.',

es: 'Salida registrada con éxito.',

);

String get _resignationErrorLabel => _byLanguage(

pt: 'Erro ao registar saída',

en: 'Failed to register resignation',

es: 'Error al registrar la salida',

);

String get _resigningLabel =>

_byLanguage(pt: 'Em saída', en: 'Resigning', es: 'En salida');

String get _activeProbationLabel => _byLanguage(

pt: 'Ativo em Experiência',

en: 'Active on Probation',

es: 'Activo en período de prueba',

);

String get _candidateLabel =>

_byLanguage(pt: 'Candidato', en: 'Candidate', es: 'Candidato');

String get _changesLoadErrorLabel => _byLanguage(

pt: 'Erro ao carregar alterações',

en: 'Could not load changes',

es: 'No fue posible cargar los cambios',

);

String get _changesEmptyLabel => _byLanguage(

pt: 'Sem alterações registadas.',

en: 'No changes recorded.',

es: 'No hay cambios registrados.',

);

String get _changeDateLabel =>

_byLanguage(pt: 'Data', en: 'Date', es: 'Fecha');

String get _changeOldValueLabel =>

_byLanguage(pt: 'Valor anterior', en: 'Old value', es: 'Valor anterior');

String get _changeNewValueLabel =>

_byLanguage(pt: 'Novo valor', en: 'New value', es: 'Nuevo valor');

String get _changeChangedByLabel =>

_byLanguage(pt: 'Alterado por', en: 'Changed by', es: 'Cambiado por');

String get _userOnboardingLoadErrorLabel => _l10n.userOnboardingLoadError;

String get _userOnboardingEmptyLabel => _l10n.userOnboardingEmpty;

String get _userOnboardingTasksLoadErrorLabel =>

_l10n.userOnboardingTasksLoadError;

String get _userOnboardingNoTasksAssignedLabel =>

_l10n.userOnboardingNoTasksAssigned;

  

String _byLanguage({

required String pt,

required String en,

required String es,

}) {

switch (_languageCode) {

case 'en':

return en;

case 'es':

return es;

default:

return pt;

}

}

}

  

class _EmployeeCreateDocumentSheet extends StatefulWidget {

const _EmployeeCreateDocumentSheet({

required this.employeeId,

required this.documentRepository,

});

  

final String employeeId;

final DocumentRepository documentRepository;

  

@override

State<_EmployeeCreateDocumentSheet> createState() => _EmployeeCreateDocumentSheetState();

}

  

class _EmployeeCreateDocumentSheetState extends State<_EmployeeCreateDocumentSheet> {

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final TextEditingController _titleController = TextEditingController();

final TextEditingController _descriptionController = TextEditingController();

final TextEditingController _urlController = TextEditingController();

final TextEditingController _fileNameController = TextEditingController();

  

DocumentCategory _selectedCategory = DocumentCategory.contract;

DocumentVisibility _selectedVisibility = DocumentVisibility.employee;

_DocumentSourceType _sourceType = _DocumentSourceType.file;

PlatformFile? _selectedFile;

bool _isSubmitting = false;

  

@override

void dispose() {

_titleController.dispose();

_descriptionController.dispose();

_urlController.dispose();

_fileNameController.dispose();

super.dispose();

}

  

Future<void> _pickFile() async {

final l10n = AppLocalizations.of(context)!;

try {

final result = await FilePicker.platform.pickFiles(

type: FileType.any,

allowMultiple: false,

withData: false,

);

if (result == null || result.files.isEmpty) return;

final file = result.files.single;

setState(() {

_selectedFile = file;

_fileNameController.text = file.name;

});

} on PlatformException catch (error) {

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(

SnackBar(

content: Text('${l10n.documentsFilePickerOpenError}: ${error.message ?? error.code}'),

behavior: SnackBarBehavior.floating,

),

);

} catch (error) {

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(

SnackBar(

content: Text('${l10n.documentsFileSelectionError}: $error'),

behavior: SnackBarBehavior.floating,

),

);

}

}

  

Future<void> _submit() async {

final l10n = AppLocalizations.of(context)!;

final isValid = _formKey.currentState?.validate() ?? false;

if (!isValid) return;

  

if (_sourceType == _DocumentSourceType.file &&

(_selectedFile?.path == null || _selectedFile!.path!.isEmpty)) {

ScaffoldMessenger.of(context).showSnackBar(

SnackBar(

content: Text(l10n.documentsSelectFileToContinue),

behavior: SnackBarBehavior.floating,

),

);

return;

}

  

setState(() {

_isSubmitting = true;

});

  

try {

await widget.documentRepository.create(

employeeId: widget.employeeId,

category: _categoryApiValue(_selectedCategory),

title: _titleController.text.trim(),

description: _descriptionController.text.trim(),

fileUrl: _sourceType == _DocumentSourceType.url ? _urlController.text.trim() : null,

fileName: _fileNameController.text.trim(),

fileSize: _sourceType == _DocumentSourceType.file ? _selectedFile?.size : null,

visibility: _visibilityApiValue(_selectedVisibility),

filePath: _sourceType == _DocumentSourceType.file ? _selectedFile?.path : null,

);

  

if (!mounted) return;

Navigator.of(context).pop(true);

ScaffoldMessenger.of(context).showSnackBar(

SnackBar(

content: Text(l10n.documentsCreatedSuccess),

behavior: SnackBarBehavior.floating,

),

);

} catch (error) {

if (!mounted) return;

setState(() {

_isSubmitting = false;

});

ScaffoldMessenger.of(context).showSnackBar(

SnackBar(

content: Text('${l10n.documentsCreateError}: $error'),

behavior: SnackBarBehavior.floating,

),

);

}

}

  

@override

Widget build(BuildContext context) {

final l10n = AppLocalizations.of(context)!;

return SafeArea(

child: Padding(

padding: EdgeInsets.only(

left: AppSpacing.xl,

right: AppSpacing.xl,

top: AppSpacing.xl,

bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,

),

child: SingleChildScrollView(

child: Form(

key: _formKey,

child: Column(

mainAxisSize: MainAxisSize.min,

crossAxisAlignment: CrossAxisAlignment.start,

children: [

Row(

children: [

const Spacer(),

Container(

width: 44,

height: 4,

decoration: BoxDecoration(

color: Colors.black12,

borderRadius: BorderRadius.circular(999),

),

),

const Spacer(),

IconButton(

onPressed: () => Navigator.of(context).pop(false),

icon: const Icon(Icons.close_rounded, color: Colors.black54),

),

],

),

const SizedBox(height: AppSpacing.lg),

Text(

l10n.documentsAddTitle,

style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),

),

const SizedBox(height: AppSpacing.md),

TextFormField(

controller: _titleController,

decoration: _inputDecoration(l10n.documentsTitleLabel),

validator: (value) => value == null || value.trim().isEmpty

? l10n.documentsTitleRequired

: null,

),

const SizedBox(height: AppSpacing.md),

TextFormField(

controller: _descriptionController,

decoration: _inputDecoration(l10n.documentsDescriptionLabel),

minLines: 2,

maxLines: 3,

),

const SizedBox(height: AppSpacing.md),

DropdownButtonFormField<DocumentCategory>(

initialValue: _selectedCategory,

decoration: _inputDecoration(l10n.documentsCategoryLabel),

items: DocumentCategory.values.map((category) {

return DropdownMenuItem<DocumentCategory>(

value: category,

child: Text(_categoryLabel(context, category), style: GoogleFonts.inter(fontSize: 14)),

);

}).toList(),

onChanged: (value) {

if (value != null) setState(() => _selectedCategory = value);

},

),

const SizedBox(height: AppSpacing.md),

DropdownButtonFormField<DocumentVisibility>(

initialValue: _selectedVisibility,

decoration: _inputDecoration(l10n.documentsVisibilityLabel),

items: DocumentVisibility.values.map((visibility) {

return DropdownMenuItem<DocumentVisibility>(

value: visibility,

child: Text(_visibilityLabel(context, visibility), style: GoogleFonts.inter(fontSize: 14)),

);

}).toList(),

onChanged: (value) {

if (value != null) setState(() => _selectedVisibility = value);

},

),

const SizedBox(height: AppSpacing.lg),

Row(

children: [

Expanded(

child: _SourceToggle(

label: l10n.documentsLinkSourceLabel,

selected: _sourceType == _DocumentSourceType.url,

onTap: () => setState(() => _sourceType = _DocumentSourceType.url),

),

),

const SizedBox(width: AppSpacing.sm),

Expanded(

child: _SourceToggle(

label: l10n.documentsFileSourceLabel,

selected: _sourceType == _DocumentSourceType.file,

onTap: () => setState(() => _sourceType = _DocumentSourceType.file),

),

),

],

),

const SizedBox(height: AppSpacing.md),

if (_sourceType == _DocumentSourceType.url) ...[

TextFormField(

controller: _urlController,

decoration: _inputDecoration(l10n.documentsExternalLinkLabel),

validator: (value) {

if (_sourceType != _DocumentSourceType.url) return null;

return value == null || value.trim().isEmpty

? l10n.documentsFileUrlRequired

: null;

},

),

const SizedBox(height: AppSpacing.md),

TextFormField(

controller: _fileNameController,

decoration: _inputDecoration(l10n.documentsDisplayNameLabel),

validator: (value) => value == null || value.trim().isEmpty

? l10n.documentsFileNameRequired

: null,

),

] else ...[

OutlinedButton.icon(

onPressed: _pickFile,

icon: const Icon(Icons.attach_file_rounded, color: Colors.black),

label: Text(

_selectedFile == null ? l10n.documentsChooseFile : _selectedFile!.name,

style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.w700),

),

style: OutlinedButton.styleFrom(

minimumSize: const Size.fromHeight(52),

side: const BorderSide(color: Colors.black12),

),

),

const SizedBox(height: AppSpacing.sm),

Text(

l10n.documentsFilePickerHint,

style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),

),

],

const SizedBox(height: AppSpacing.xl),

SizedBox(

width: double.infinity,

child: ElevatedButton(

onPressed: _isSubmitting ? null : _submit,

style: ElevatedButton.styleFrom(

backgroundColor: Colors.black,

foregroundColor: Colors.white,

minimumSize: const Size.fromHeight(52),

),

child: _isSubmitting

? const SizedBox(

width: 18,

height: 18,

child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),

)

: Text(

l10n.documentsSaveLabel,

style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700),

),

),

),

],

),

),

),

),

);

}

  

InputDecoration _inputDecoration(String label) {

return InputDecoration(

labelText: label,

filled: true,

fillColor: const Color(0xFFF7F5F1),

border: OutlineInputBorder(

borderRadius: BorderRadius.circular(12),

borderSide: BorderSide.none,

),

);

}

  

String _categoryApiValue(DocumentCategory category) {

switch (category) {

case DocumentCategory.idTax:

return 'id_tax';

case DocumentCategory.onboarding:

return 'onboarding';

default:

return category.name;

}

}

  

String _visibilityApiValue(DocumentVisibility visibility) {

switch (visibility) {

case DocumentVisibility.all:

return 'all';

case DocumentVisibility.hrOnly:

return 'hr_only';

default:

return visibility.name;

}

}

  

String _categoryLabel(BuildContext context, DocumentCategory category) {

final l10n = AppLocalizations.of(context)!;

switch (category) {

case DocumentCategory.contract:

return l10n.employeeDetailDocumentContract;

case DocumentCategory.payslip:

return l10n.employeeDetailDocumentPayslip;

case DocumentCategory.idTax:

return l10n.employeeDetailDocumentIdTax;

case DocumentCategory.trainee:

return l10n.employeeDetailDocumentTrainee;

case DocumentCategory.policy:

return l10n.employeeDetailDocumentPolicy;

case DocumentCategory.certificate:

return l10n.employeeDetailDocumentCertificate;

case DocumentCategory.onboarding:

return l10n.employeeDetailDocumentOnboarding;

case DocumentCategory.other:

return l10n.employeeDetailDocumentOther;

}

}

  

String _visibilityLabel(BuildContext context, DocumentVisibility visibility) {

final l10n = AppLocalizations.of(context)!;

switch (visibility) {

case DocumentVisibility.all:

return l10n.documentsVisibilityAll;

case DocumentVisibility.employee:

return l10n.leaveFallbackEmployee;

case DocumentVisibility.manager:

return l10n.documentsVisibilityManager;

case DocumentVisibility.hrOnly:

return l10n.documentsVisibilityHr;

}

}

}

  

class _SourceToggle extends StatelessWidget {

const _SourceToggle({

required this.label,

required this.selected,

required this.onTap,

});

  

final String label;

final bool selected;

final VoidCallback onTap;

  

@override

Widget build(BuildContext context) {

return InkWell(

onTap: onTap,

borderRadius: BorderRadius.circular(14),

child: Container(

padding: const EdgeInsets.symmetric(vertical: 12),

decoration: BoxDecoration(

color: selected ? Colors.black : const Color(0xFFF7F5F1),

borderRadius: BorderRadius.circular(14),

border: Border.all(color: selected ? Colors.black : Colors.black12),

),

alignment: Alignment.center,

child: Text(

label,

style: GoogleFonts.inter(

fontSize: 13,

fontWeight: FontWeight.w700,

color: selected ? Colors.white : Colors.black87,

),

),

),

);

}