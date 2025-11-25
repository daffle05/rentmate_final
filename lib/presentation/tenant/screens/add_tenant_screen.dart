import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/themes/theme.dart';
import '/features/tenant/data/models/tenant_model.dart';
import '/presentation/providers/tenant_providers.dart';

class AddTenantScreen extends ConsumerStatefulWidget {
const AddTenantScreen({super.key});

@override
ConsumerState<AddTenantScreen> createState() => _AddTenantScreenState();
}

class _AddTenantScreenState extends ConsumerState<AddTenantScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final Uuid _uuid = Uuid();

@override
Widget build(BuildContext context) {
final tenantController = ref.read(tenantControllerProvider.notifier);

return Scaffold(
  appBar: AppBar(
    title: const Text('Add Tenant'),
  ),
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: FormBuilder(
      key: _formKey,
      child: ListView(
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(labelText: 'Tenant Name'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(2),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'roomNumber',
            decoration: const InputDecoration(labelText: 'Room Number'),
            validator: FormBuilderValidators.required(),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'rentAmount',
            decoration: const InputDecoration(labelText: 'Rent Amount'),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
              FormBuilderValidators.min(0),
            ]),
          ),
          const SizedBox(height: 16),
          FormBuilderDateTimePicker(
            name: 'dueDate',
            decoration: const InputDecoration(labelText: 'Due Date'),
            inputType: InputType.date,
            format: DateFormat('yyyy-MM-dd'),
            validator: FormBuilderValidators.required(),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
            ),
            onPressed: () async {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                final values = _formKey.currentState!.value;

                final tenant = TenantModel(
                  id: _uuid.v4(),
                  name: values['name'],
                  roomNumber: values['roomNumber'],
                  rentAmount: double.parse(values['rentAmount']),
                  dueDate: values['dueDate'],
                );

                await tenantController.addTenant(tenant);

                if (!context.mounted) return;
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save Tenant'),
          ),
        ],
      ),
    ),
  ),
);

}
}

// Using `package:uuid` for unique ids; no local stub needed.
