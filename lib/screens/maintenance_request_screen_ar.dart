import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/maintenance_request.dart';
import '../providers/maintenance_provider.dart';
import '../theme/shadcn_theme.dart';

class MaintenanceRequestScreenAr extends StatefulWidget {
  const MaintenanceRequestScreenAr({super.key});

  @override
  State<MaintenanceRequestScreenAr> createState() =>
      _MaintenanceRequestScreenArState();
}

class _MaintenanceRequestScreenArState
    extends State<MaintenanceRequestScreenAr> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String selectedPriority = 'متوسطة';
  String selectedCategory = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('طلب صيانة جديد'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add Photo Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 48,
                        color: ShadTheme.primary,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'إضافة صورة',
                        style: TextStyle(
                          fontSize: 18,
                          color: ShadTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'اختياري ولكن مستحسن',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('الكاميرا'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ShadTheme.primary,
                              side: const BorderSide(color: ShadTheme.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.photo_library),
                            label: const Text('المعرض'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ShadTheme.primary,
                              side: const BorderSide(color: ShadTheme.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Title Field
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'العنوان',
                    prefixIcon:
                        const Icon(Icons.title, color: ShadTheme.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال عنوان الطلب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Location Field
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'الموقع المحدد',
                    prefixIcon:
                        const Icon(Icons.location_on, color: ShadTheme.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء تحديد الموقع';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Category Section
                const Text(
                  'التصنيف',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildCategoryChip('كهربائي', Icons.electrical_services),
                    _buildCategoryChip('سباكة', Icons.water_drop),
                    _buildCategoryChip('نظافة', Icons.cleaning_services),
                    _buildCategoryChip('إنشائي', Icons.architecture),
                    _buildCategoryChip('أخرى', Icons.build),
                  ],
                ),
                if (selectedCategory.isEmpty) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'الرجاء اختيار تصنيف',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // Priority Section
                const Text(
                  'الأولوية',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildPriorityButton(
                        'منخفضة', Colors.green[100]!, Colors.green),
                    const SizedBox(width: 8),
                    _buildPriorityButton(
                        'متوسطة', Colors.orange[100]!, Colors.orange),
                    const SizedBox(width: 8),
                    _buildPriorityButton('عالية', Colors.red[100]!, Colors.red),
                  ],
                ),
                const SizedBox(height: 24),

                // Description Field
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'قم بتوفير معلومات مفصلة عن المشكلة...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء وصف المشكلة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _submitRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ShadTheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send),
                              SizedBox(width: 8),
                              Text(
                                'إرسال الطلب',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
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

  void _submitRequest() {
    if (!_formKey.currentState!.validate() || selectedCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إكمال جميع الحقول المطلوبة')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Create maintenance request
      final request = MaintenanceRequest(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        location: _locationController.text,
        category: selectedCategory,
        priority: selectedPriority,
        description: _descriptionController.text,
        createdAt: DateTime.now(),
      );

      // Add request to provider
      context.read<MaintenanceProvider>().addRequest(request);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال طلب الصيانة بنجاح')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('حدث خطأ أثناء إرسال الطلب')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    final isSelected = selectedCategory == label;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? Colors.white : ShadTheme.primary,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          selectedCategory = selected ? label : '';
        });
      },
      selectedColor: ShadTheme.primary,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildPriorityButton(
      String priority, Color bgColor, MaterialColor textColor) {
    final isSelected = selectedPriority == priority;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPriority = priority;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? bgColor : Colors.transparent,
            border: Border.all(
              color: isSelected ? textColor : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            priority,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? textColor : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
