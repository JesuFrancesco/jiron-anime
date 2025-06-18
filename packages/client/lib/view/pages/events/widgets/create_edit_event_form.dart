import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/model/entity/events/event.dart';
import 'package:jiron_anime/viewmodel/controllers/events/create_edit_event_controller.dart';

class CreateEditEventForm extends StatelessWidget {
  final CreateEditEventController c;
  final bool isEdit;
  final Event? initialEvent;

  const CreateEditEventForm({
    super.key,
    required this.c,
    this.isEdit = false,
    this.initialEvent,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Get.theme.colorScheme;
    return Form(
      key: c.formKey,
      child: Obx(() {
        final isVirtual = c.modality.value == 'Virtual';
        final isOutside = c.location.value == 'Fuera de la Universidad';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Imagen Principal del Evento',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            Obx(() {
              final hasImage =
                  c.mainImage.value != null ||
                  (initialEvent?.mainImageUrl != null &&
                      c.mainImage.value == null &&
                      c.showInitialImage.value);
              return Stack(
                children: [
                  GestureDetector(
                    onTap: hasImage ? null : c.pickMainImage,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child:
                          hasImage
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child:
                                    c.mainImage.value != null
                                        ? Image.file(
                                          c.mainImage.value!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 150,
                                        )
                                        : Image.network(
                                          initialEvent!.mainImageUrl!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 150,
                                        ),
                              )
                              : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Presiona aquí para subir la imagen',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                    ),
                  ),
                  if (hasImage)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            c.deleteImage();
                          },
                        ),
                      ),
                    ),
                ],
              );
            }),
            const SizedBox(height: 24),
            const Text(
              'Título del Evento',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue: c.title.value,
              onChanged: (v) => c.title.value = v,
              decoration: const InputDecoration(
                hintText: 'Ej. Lanzamiento Manga Shonen Jump',
                border: OutlineInputBorder(),
              ),
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Campo obligatorio'
                          : null,
            ),
            const SizedBox(height: 16),
            const Text(
              'Tipo de Evento',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (c.isLoadingEventTypes.value)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (c.eventTypesError.value != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Error: \\${c.eventTypesError.value}',
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else
              DropdownButtonFormField<int>(
                value: c.eventTypeId.value,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text(
                  'Selecciona un tipo de evento',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                items:
                    c.eventTypes
                        .map(
                          (type) => DropdownMenuItem(
                            value: type.id,
                            child: Text(
                              type.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  final selected = c.eventTypes.firstWhereOrNull(
                    (e) => e.id == value,
                  );
                  c.eventTypeId.value = value;
                  c.eventTypeName.value = selected?.name;
                },
                validator:
                    (value) => value == null ? 'Campo obligatorio' : null,
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fecha',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: TextEditingController(text: c.date.value),
                        decoration: const InputDecoration(
                          hintText: 'dd/mm/yyyy',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Campo obligatorio'
                                    : null,
                        onTap: () async {
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: now,
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            c.date.value =
                                '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hora',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: TextEditingController(text: c.time.value),
                        decoration: const InputDecoration(
                          hintText: '--:--',
                          prefixIcon: Icon(Icons.access_time),
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Campo obligatorio'
                                    : null,
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null && context.mounted) {
                            c.time.value = picked.format(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Duración (minutos)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        initialValue:
                            c.duration.value == 0
                                ? ''
                                : c.duration.value.toString(),
                        onChanged:
                            (v) => c.duration.value = int.tryParse(v) ?? 0,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Ej. 180',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value == null ||
                                        value.isEmpty ||
                                        int.tryParse(value) == null ||
                                        int.parse(value) <= 0
                                    ? 'Campo obligatorio'
                                    : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Capacidad (personas)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        initialValue:
                            c.capacity.value == 0
                                ? ''
                                : c.capacity.value.toString(),
                        onChanged:
                            (v) => c.capacity.value = int.tryParse(v) ?? 0,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Ej. 200',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value == null ||
                                        value.isEmpty ||
                                        int.tryParse(value) == null ||
                                        int.parse(value) <= 0
                                    ? 'Campo obligatorio'
                                    : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Modalidad',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'Presencial',
                      groupValue: c.modality.value,
                      onChanged: (value) => c.modality.value = value!,
                    ),
                    const Text('Presencial'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'Virtual',
                      groupValue: c.modality.value,
                      onChanged: (value) => c.modality.value = value!,
                    ),
                    const Text('Virtual'),
                  ],
                ),
              ],
            ),
            if (isVirtual) ...[
              const SizedBox(height: 8),
              const Text(
                'Enlace de Acceso',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: c.accessLink.value,
                onChanged: (v) => c.accessLink.value = v,
                decoration: const InputDecoration(
                  hintText: 'Ej. https://meet.google.com/xxx',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obligatorio'
                            : null,
              ),
            ] else ...[
              const SizedBox(height: 8),
              const Text(
                'Ubicación',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Dentro de la Universidad',
                    groupValue: c.location.value,
                    onChanged: (value) => c.location.value = value!,
                  ),
                  const Text('Dentro de la Universidad'),
                  Radio<String>(
                    value: 'Fuera de la Universidad',
                    groupValue: c.location.value,
                    onChanged: (value) => c.location.value = value!,
                  ),
                  const Text('Fuera de la Universidad'),
                ],
              ),
              const SizedBox(height: 8),
              if (!isOutside) ...[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: c.building.value,
                        onChanged: (v) => c.building.value = v,
                        decoration: const InputDecoration(
                          hintText: 'Ej. Edificio A - Ciencias',
                          labelText: 'Edificio',
                          border: OutlineInputBorder(),
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Campo obligatorio'
                                    : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        initialValue: c.room.value,
                        onChanged: (v) => c.room.value = v,
                        decoration: const InputDecoration(
                          hintText: 'Ej. 101, Auditorio A',
                          labelText: 'Salon (Opcional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                TextFormField(
                  initialValue: c.externalLocation.value,
                  onChanged: (v) => c.externalLocation.value = v,
                  decoration: const InputDecoration(
                    hintText: 'Ubicación',
                    labelText: 'Ubicación',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Campo obligatorio'
                              : null,
                ),
              ],
            ],
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CheckboxListTile(
                value: c.isFree.value,
                onChanged: (value) => c.isFree.value = value ?? false,
                title: const Text('Evento gratuito'),
                subtitle: const Text(
                  'Marca esta casilla si el evento no tiene costo de entrada',
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            if (!c.isFree.value) ...[
              const SizedBox(height: 16),
              const Text(
                'Precio (S/.)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: c.price.value,
                onChanged: (v) => c.price.value = v,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ej. 150',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo obligatorio'
                            : null,
              ),
            ],
            const SizedBox(height: 16),
            const Text(
              'Descripción',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue: c.description.value,
              onChanged: (v) => c.description.value = v,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Describe tu evento...',
                border: OutlineInputBorder(),
              ),
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Campo obligatorio'
                          : null,
            ),
            const SizedBox(height: 16),
            const Text(
              'Actividades',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (c.activities.isNotEmpty)
              ...c.activities.asMap().entries.map((entry) {
                final idx = entry.key;
                final act = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            act[0],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => c.deleteActivity(idx),
                      ),
                    ],
                  ),
                );
              }),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: c.activityInputController,
                    decoration: const InputDecoration(
                      hintText: 'Ej. 150',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 48,
                  width: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: c.addActivity,
                    child: const Icon(Icons.add, size: 28),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: colors.primary),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () => c.submitForm(context),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(isEdit ? 'Editar Evento' : 'Crear Evento'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        );
      }),
    );
  }
}
