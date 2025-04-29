import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MaintenanceRequestScreen extends HookWidget {
  const MaintenanceRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final locationController = useTextEditingController();
    final selectedCategory = useState<String>('كهرباء');
    final selectedPriority = useState<String>('متوسطة');
    final isLoading = useState(false);

    final categories = [
      'كهرباء',
      'سباكة',
      'تكييف',
      'نظافة',
      'صوتيات',
      'أخرى',
    ];

    final priorities = [
      'عالية',
      'متوسطة',
      'منخفضة',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب صيانة جديد'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Field
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'عنوان الطلب',
                  hintText: 'أدخل عنواناً مختصراً للطلب',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory.value,
                decoration: InputDecoration(
                  labelText: 'نوع الصيانة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedCategory.value = value;
                  }
                },
              ),
              const SizedBox(height: 16),

              // Priority Dropdown
              DropdownButtonFormField<String>(
                value: selectedPriority.value,
                decoration: InputDecoration(
                  labelText: 'الأولوية',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: priorities.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedPriority.value = value;
                  }
                },
              ),
              const SizedBox(height: 16),

              // Location Field
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'الموقع داخل المسجد',
                  hintText: 'حدد موقع المشكلة بدقة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),

              // Description Field
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'وصف المشكلة',
                  hintText: 'اشرح المشكلة بالتفصيل',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 24),

              // Add Photos Button
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement photo upload
                },
                icon: const Icon(Icons.photo_camera),
                label: const Text('إضافة صور'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : () {
                          // TODO: Implement submit logic
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'إرسال الطلب',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
