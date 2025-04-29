// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:intl/intl.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen>
//     with SingleTickerProviderStateMixin {
//   final DataService _dataService = DataService();
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();

//   List<MaintenanceRequest> _searchResults = [];
//   List<SearchHistoryItem> _searchHistory = [];
//   User? _currentUser;

//   // Filter states
//   MaintenanceCategory? _categoryFilter;
//   RequestStatus? _statusFilter;
//   Priority? _priorityFilter;
//   DateTimeRange? _dateRange;

//   bool _isLoading = false;
//   bool _hasSearched = false;
//   String _currentQuery = '';

//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserAndSearchHistory();

//     _searchController.addListener(_onSearchChanged);

//     // Animation setup
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     // You could implement real-time search here or show/hide clear button
//     // For now, this is just a placeholder
//     setState(() {});
//   }

//   Future<void> _loadUserAndSearchHistory() async {
//     setState(() => _isLoading = true);

//     try {
//       // Load current user
//       final currentUser = await _dataService.getCurrentUser();
//       if (currentUser == null) {
//         if (mounted) {
//           Navigator.of(context).pushReplacementNamed(AppRoutes.login);
//         }
//         return;
//       }

//       // Load search history
//       final searchHistory = await _dataService.getSearchHistory();

//       if (mounted) {
//         setState(() {
//           _currentUser = currentUser;
//           _searchHistory = searchHistory;
//           _isLoading = false;
//         });
//       }
//     } catch (error) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error: ${error.toString()}')));
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   Future<void> _performSearch() async {
//     final query = _searchController.text.trim();
//     if (query.isEmpty &&
//         (_categoryFilter == null &&
//             _statusFilter == null &&
//             _priorityFilter == null &&
//             _dateRange == null)) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Please enter a search term or select filters')));
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//       _currentQuery = query;
//     });

//     try {
//       // Perform search with all filters
//       final results = await _dataService.searchMaintenanceRequests(
//         query: query,
//         categoryFilter: _categoryFilter,
//         statusFilter: _statusFilter,
//         priorityFilter: _priorityFilter,
//         startDate: _dateRange?.start,
//         endDate: _dateRange?.end,
//         createdById:
//             _currentUser?.role == UserRole.imamWorker ? _currentUser?.id : null,
//         assignedToId: _currentUser?.role == UserRole.maintenance
//             ? _currentUser?.companyId
//             : null,
//       );

//       // Save search to history if it has query text
//       if (query.isNotEmpty) {
//         await _dataService.saveSearchQuery(query, results.length);
//         // Reload search history
//         final updatedHistory = await _dataService.getSearchHistory();

//         if (mounted) {
//           setState(() {
//             _searchHistory = updatedHistory;
//           });
//         }
//       }

//       if (mounted) {
//         setState(() {
//           _searchResults = results;
//           _isLoading = false;
//           _hasSearched = true;
//         });
//       }
//     } catch (error) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Search error: ${error.toString()}')));
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   void _clearSearch() {
//     setState(() {
//       _searchController.clear();
//       _searchResults = [];
//       _hasSearched = false;
//       _currentQuery = '';
//       _categoryFilter = null;
//       _statusFilter = null;
//       _priorityFilter = null;
//       _dateRange = null;
//     });
//   }

//   void _useHistoryItem(SearchHistoryItem item) {
//     setState(() {
//       _searchController.text = item.query;
//       _currentQuery = item.query;
//     });
//     _performSearch();
//   }

//   void _showFilterBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setModalState) {
//           return Container(
//             padding: EdgeInsets.fromLTRB(
//                 20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.surface,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Handle bar
//                   Center(
//                     child: Container(
//                       width: 40,
//                       height: 4,
//                       margin: const EdgeInsets.only(bottom: 20),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context)
//                             .colorScheme
//                             .outline
//                             .withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),

//                   // Header with reset button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Search Filters',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                       TextButton.icon(
//                         onPressed: () {
//                           setModalState(() {
//                             _categoryFilter = null;
//                             _statusFilter = null;
//                             _priorityFilter = null;
//                             _dateRange = null;
//                           });
//                         },
//                         icon: const Icon(Icons.refresh, size: 18),
//                         label: const Text('Reset All'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // Category Filter
//                   Text(
//                     'Category',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: [
//                       _buildFilterChip(
//                         label: 'Electrical',
//                         icon: Icons.electrical_services,
//                         isSelected:
//                             _categoryFilter == MaintenanceCategory.electrical,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _categoryFilter = selected
//                                 ? MaintenanceCategory.electrical
//                                 : null;
//                           });
//                         },
//                       ),
//                       _buildFilterChip(
//                         label: 'Plumbing',
//                         icon: Icons.water_drop,
//                         isSelected:
//                             _categoryFilter == MaintenanceCategory.plumbing,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _categoryFilter =
//                                 selected ? MaintenanceCategory.plumbing : null;
//                           });
//                         },
//                       ),
//                       _buildFilterChip(
//                         label: 'Cleaning',
//                         icon: Icons.cleaning_services,
//                         isSelected:
//                             _categoryFilter == MaintenanceCategory.cleaning,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _categoryFilter =
//                                 selected ? MaintenanceCategory.cleaning : null;
//                           });
//                         },
//                       ),
//                       _buildFilterChip(
//                         label: 'Structural',
//                         icon: Icons.architecture,
//                         isSelected:
//                             _categoryFilter == MaintenanceCategory.structural,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _categoryFilter = selected
//                                 ? MaintenanceCategory.structural
//                                 : null;
//                           });
//                         },
//                       ),
//                       _buildFilterChip(
//                         label: 'Other',
//                         icon: Icons.build,
//                         isSelected:
//                             _categoryFilter == MaintenanceCategory.other,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _categoryFilter =
//                                 selected ? MaintenanceCategory.other : null;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),

//                   // Status Filter
//                   Text(
//                     'Status',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: [
//                       _buildStatusChip(
//                         label: 'Submitted',
//                         status: RequestStatus.submitted,
//                         isSelected: _statusFilter == RequestStatus.submitted,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _statusFilter =
//                                 selected ? RequestStatus.submitted : null;
//                           });
//                         },
//                       ),
//                       _buildStatusChip(
//                         label: 'In Progress',
//                         status: RequestStatus.inProgress,
//                         isSelected: _statusFilter == RequestStatus.inProgress,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _statusFilter =
//                                 selected ? RequestStatus.inProgress : null;
//                           });
//                         },
//                       ),
//                       _buildStatusChip(
//                         label: 'Completed',
//                         status: RequestStatus.completed,
//                         isSelected: _statusFilter == RequestStatus.completed,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _statusFilter =
//                                 selected ? RequestStatus.completed : null;
//                           });
//                         },
//                       ),
//                       _buildStatusChip(
//                         label: 'On Hold',
//                         status: RequestStatus.onHold,
//                         isSelected: _statusFilter == RequestStatus.onHold,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _statusFilter =
//                                 selected ? RequestStatus.onHold : null;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),

//                   // Priority Filter
//                   Text(
//                     'Priority',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: [
//                       _buildPriorityChip(
//                         label: 'Low',
//                         priority: Priority.low,
//                         color: Colors.green,
//                         isSelected: _priorityFilter == Priority.low,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _priorityFilter = selected ? Priority.low : null;
//                           });
//                         },
//                       ),
//                       _buildPriorityChip(
//                         label: 'Medium',
//                         priority: Priority.medium,
//                         color: Colors.orange,
//                         isSelected: _priorityFilter == Priority.medium,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _priorityFilter = selected ? Priority.medium : null;
//                           });
//                         },
//                       ),
//                       _buildPriorityChip(
//                         label: 'High',
//                         priority: Priority.high,
//                         color: Colors.red,
//                         isSelected: _priorityFilter == Priority.high,
//                         onSelected: (selected) {
//                           setModalState(() {
//                             _priorityFilter = selected ? Priority.high : null;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),

//                   // Date Range Picker
//                   Text(
//                     'Date Range',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           icon: const Icon(Icons.calendar_today),
//                           label: Text(_dateRange != null
//                               ? '${DateFormat('MMM d').format(_dateRange!.start)} - ${DateFormat('MMM d').format(_dateRange!.end)}'
//                               : 'Select Dates'),
//                           onPressed: () async {
//                             final now = DateTime.now();
//                             final initialDateRange = _dateRange ??
//                                 DateTimeRange(
//                                   start: now.subtract(const Duration(days: 30)),
//                                   end: now,
//                                 );

//                             final newDateRange = await showDateRangePicker(
//                               context: context,
//                               initialDateRange: initialDateRange,
//                               firstDate: DateTime(2020),
//                               lastDate: DateTime(2030),
//                               builder: (context, child) {
//                                 return Theme(
//                                   data: Theme.of(context).copyWith(
//                                     colorScheme:
//                                         Theme.of(context).colorScheme.copyWith(
//                                               primary: Theme.of(context)
//                                                   .colorScheme
//                                                   .primary,
//                                             ),
//                                   ),
//                                   child: child!,
//                                 );
//                               },
//                             );

//                             if (newDateRange != null) {
//                               setModalState(() {
//                                 _dateRange = newDateRange;
//                               });
//                             }
//                           },
//                           style: OutlinedButton.styleFrom(
//                             side: BorderSide(
//                                 color: Theme.of(context).colorScheme.primary),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (_dateRange != null) ...[
//                         const SizedBox(width: 8),
//                         IconButton(
//                           icon: const Icon(Icons.clear),
//                           onPressed: () {
//                             setModalState(() {
//                               _dateRange = null;
//                             });
//                           },
//                           tooltip: 'Clear dates',
//                         ),
//                       ],
//                     ],
//                   ),
//                   const SizedBox(height: 32),

//                   // Apply Button
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         // Update main state with filter values from modal
//                         _categoryFilter = _categoryFilter;
//                         _statusFilter = _statusFilter;
//                         _priorityFilter = _priorityFilter;
//                         _dateRange = _dateRange;
//                       });
//                       Navigator.pop(context);
//                       _performSearch(); // Apply search with new filters
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).colorScheme.primary,
//                       foregroundColor: Theme.of(context).colorScheme.onPrimary,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       minimumSize: const Size(double.infinity, 50),
//                     ),
//                     child: Text(
//                       'Apply Filters',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).colorScheme.onPrimary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFilterChip({
//     required String label,
//     required IconData icon,
//     required bool isSelected,
//     required Function(bool) onSelected,
//   }) {
//     final theme = Theme.of(context);

//     return FilterChip(
//       selected: isSelected,
//       label: Text(label),
//       avatar: Icon(
//         icon,
//         size: 18,
//         color: isSelected
//             ? theme.colorScheme.onPrimary
//             : theme.colorScheme.primary,
//       ),
//       selectedColor: theme.colorScheme.primary,
//       checkmarkColor: theme.colorScheme.onPrimary,
//       backgroundColor: theme.colorScheme.surface,
//       side: BorderSide(
//         color: isSelected ? Colors.transparent : theme.colorScheme.outline,
//       ),
//       labelStyle: TextStyle(
//         color: isSelected
//             ? theme.colorScheme.onPrimary
//             : theme.colorScheme.onSurface,
//         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       onSelected: onSelected,
//     );
//   }

//   Widget _buildStatusChip({
//     required String label,
//     required RequestStatus status,
//     required bool isSelected,
//     required Function(bool) onSelected,
//   }) {
//     final theme = Theme.of(context);
//     final color = _getStatusColor(status);

//     return FilterChip(
//       selected: isSelected,
//       label: Text(label),
//       selectedColor: color,
//       checkmarkColor: Colors.white,
//       backgroundColor: color.withOpacity(0.1),
//       side: BorderSide(
//         color: isSelected ? Colors.transparent : color.withOpacity(0.5),
//       ),
//       labelStyle: TextStyle(
//         color: isSelected ? Colors.white : color,
//         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       onSelected: onSelected,
//     );
//   }

//   Widget _buildPriorityChip({
//     required String label,
//     required Priority priority,
//     required Color color,
//     required bool isSelected,
//     required Function(bool) onSelected,
//   }) {
//     final theme = Theme.of(context);

//     return FilterChip(
//       selected: isSelected,
//       label: Text(label),
//       selectedColor: color,
//       checkmarkColor: Colors.white,
//       backgroundColor: color.withOpacity(0.1),
//       side: BorderSide(
//         color: isSelected ? Colors.transparent : color.withOpacity(0.5),
//       ),
//       labelStyle: TextStyle(
//         color: isSelected ? Colors.white : color,
//         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       onSelected: onSelected,
//     );
//   }

//   Color _getStatusColor(RequestStatus status) {
//     switch (status) {
//       case RequestStatus.submitted:
//       case RequestStatus.approved:
//         return Colors.blue;
//       case RequestStatus.rejected:
//         return Colors.red;
//       case RequestStatus.assigned:
//       case RequestStatus.inProgress:
//         return Colors.orange;
//       case RequestStatus.onHold:
//         return Colors.amber;
//       case RequestStatus.completed:
//       case RequestStatus.verified:
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   IconData _getCategoryIcon(MaintenanceCategory category) {
//     switch (category) {
//       case MaintenanceCategory.electrical:
//         return Icons.electrical_services;
//       case MaintenanceCategory.plumbing:
//         return Icons.water_drop;
//       case MaintenanceCategory.cleaning:
//         return Icons.cleaning_services;
//       case MaintenanceCategory.structural:
//         return Icons.architecture;
//       default:
//         return Icons.build;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     // Active filters indicator
//     final hasActiveFilters = _categoryFilter != null ||
//         _statusFilter != null ||
//         _priorityFilter != null ||
//         _dateRange != null;

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(
//         title: Text(
//           'Search Requests',
//           style: theme.textTheme.titleLarge?.copyWith(
//             color: theme.colorScheme.onSurface,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: theme.colorScheme.surface,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_rounded,
//             color: theme.colorScheme.primary,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           if (_hasSearched)
//             IconButton(
//               icon: Icon(
//                 Icons.clear_all_rounded,
//                 color: theme.colorScheme.primary,
//               ),
//               onPressed: _clearSearch,
//               tooltip: 'Clear search',
//             ),
//         ],
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Column(
//           children: [
//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _searchController,
//                       focusNode: _searchFocusNode,
//                       decoration: InputDecoration(
//                         hintText: 'Search maintenance requests...',
//                         prefixIcon: Icon(
//                           Icons.search_rounded,
//                           color: theme.colorScheme.primary,
//                         ),
//                         suffixIcon: _searchController.text.isNotEmpty
//                             ? IconButton(
//                                 icon: const Icon(Icons.clear_rounded),
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   setState(() {});
//                                 },
//                               )
//                             : null,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                         filled: true,
//                         fillColor: theme.colorScheme.primary.withOpacity(0.05),
//                       ),
//                       textInputAction: TextInputAction.search,
//                       onSubmitted: (value) => _performSearch(),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: theme.colorScheme.primary.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.filter_list_rounded,
//                         color: hasActiveFilters
//                             ? theme.colorScheme.primary
//                             : theme.colorScheme.primary.withOpacity(0.7),
//                       ),
//                       onPressed: _showFilterBottomSheet,
//                       tooltip: 'Filters',
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Active filters display
//             if (hasActiveFilters) ...[
//               Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 color: theme.colorScheme.primary.withOpacity(0.05),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.filter_alt_rounded,
//                         size: 16,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Filters:',
//                         style: theme.textTheme.bodySmall?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       // Category filter chip
//                       if (_categoryFilter != null) ...[
//                         Chip(
//                           label: Text(_getCategoryName(_categoryFilter!)),
//                           backgroundColor:
//                               theme.colorScheme.primary.withOpacity(0.1),
//                           labelStyle:
//                               TextStyle(color: theme.colorScheme.primary),
//                           padding: EdgeInsets.zero,
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                           visualDensity: VisualDensity.compact,
//                           deleteIcon: const Icon(Icons.close, size: 16),
//                           onDeleted: () {
//                             setState(() => _categoryFilter = null);
//                             _performSearch();
//                           },
//                         ),
//                         const SizedBox(width: 8),
//                       ],
//                       // Status filter chip
//                       if (_statusFilter != null) ...[
//                         Chip(
//                           label: Text(_getStatusName(_statusFilter!)),
//                           backgroundColor:
//                               _getStatusColor(_statusFilter!).withOpacity(0.1),
//                           labelStyle:
//                               TextStyle(color: _getStatusColor(_statusFilter!)),
//                           padding: EdgeInsets.zero,
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                           visualDensity: VisualDensity.compact,
//                           deleteIcon: const Icon(Icons.close, size: 16),
//                           onDeleted: () {
//                             setState(() => _statusFilter = null);
//                             _performSearch();
//                           },
//                         ),
//                         const SizedBox(width: 8),
//                       ],
//                       // Priority filter chip
//                       if (_priorityFilter != null) ...[
//                         Chip(
//                           label: Text(_getPriorityName(_priorityFilter!)),
//                           backgroundColor: _getPriorityColor(_priorityFilter!)
//                               .withOpacity(0.1),
//                           labelStyle: TextStyle(
//                               color: _getPriorityColor(_priorityFilter!)),
//                           padding: EdgeInsets.zero,
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                           visualDensity: VisualDensity.compact,
//                           deleteIcon: const Icon(Icons.close, size: 16),
//                           onDeleted: () {
//                             setState(() => _priorityFilter = null);
//                             _performSearch();
//                           },
//                         ),
//                         const SizedBox(width: 8),
//                       ],
//                       // Date range filter chip
//                       if (_dateRange != null) ...[
//                         Chip(
//                           label: Text(
//                             '${DateFormat('MM/dd').format(_dateRange!.start)} - ${DateFormat('MM/dd').format(_dateRange!.end)}',
//                           ),
//                           backgroundColor:
//                               theme.colorScheme.primary.withOpacity(0.1),
//                           labelStyle:
//                               TextStyle(color: theme.colorScheme.primary),
//                           padding: EdgeInsets.zero,
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                           visualDensity: VisualDensity.compact,
//                           deleteIcon: const Icon(Icons.close, size: 16),
//                           onDeleted: () {
//                             setState(() => _dateRange = null);
//                             _performSearch();
//                           },
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             ],

//             // Search results or history
//             Expanded(
//               child: _isLoading
//                   ? Center(
//                       child: CircularProgressIndicator(
//                           color: theme.colorScheme.primary),
//                     )
//                   : _hasSearched
//                       ? _buildSearchResults()
//                       : _buildSearchHistory(),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: _hasSearched && _searchResults.isNotEmpty
//           ? FloatingActionButton(
//               backgroundColor: theme.colorScheme.primary,
//               onPressed: () {
//                 // Scroll back to top or implement other actions
//               },
//               child: Icon(
//                 Icons.arrow_upward_rounded,
//                 color: theme.colorScheme.onPrimary,
//               ),
//             )
//           : null,
//     );
//   }

//   Widget _buildSearchResults() {
//     final theme = Theme.of(context);

//     if (_searchResults.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.search_off_rounded,
//               size: 64,
//               color: theme.colorScheme.outline,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No matching requests found',
//               style: theme.textTheme.titleMedium,
//             ),
//             if (_currentQuery.isNotEmpty) ...[
//               const SizedBox(height: 8),
//               Text(
//                 'No results for "$_currentQuery"',
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   color: theme.colorScheme.onSurface.withOpacity(0.7),
//                 ),
//               ),
//             ],
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: _clearSearch,
//               icon: const Icon(Icons.refresh),
//               label: const Text('Clear Search'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: theme.colorScheme.primary,
//                 foregroundColor: theme.colorScheme.onPrimary,
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Results count
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//           child: Text(
//             'Found ${_searchResults.length} results',
//             style: theme.textTheme.titleSmall?.copyWith(
//               color: theme.colorScheme.onSurface.withOpacity(0.7),
//             ),
//           ),
//         ),
//         // Results list
//         Expanded(
//           child: ListView.separated(
//             padding: const EdgeInsets.all(16),
//             itemCount: _searchResults.length,
//             separatorBuilder: (context, index) => const SizedBox(height: 12),
//             itemBuilder: (context, index) {
//               final request = _searchResults[index];
//               return _buildSearchResultCard(request);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchHistory() {
//     final theme = Theme.of(context);

//     if (_searchHistory.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.history_rounded,
//               size: 64,
//               color: theme.colorScheme.outline,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No recent searches',
//               style: theme.textTheme.titleMedium,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Search for maintenance requests to get started',
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 color: theme.colorScheme.onSurface.withOpacity(0.7),
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Recent Searches',
//             style: theme.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 12),
//           Expanded(
//             child: ListView.separated(
//               itemCount: _searchHistory.length,
//               separatorBuilder: (context, index) => const Divider(),
//               itemBuilder: (context, index) {
//                 final item = _searchHistory[index];
//                 return ListTile(
//                   onTap: () => _useHistoryItem(item),
//                   contentPadding: EdgeInsets.zero,
//                   leading: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: theme.colorScheme.primary.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.history_rounded,
//                       color: theme.colorScheme.primary,
//                       size: 20,
//                     ),
//                   ),
//                   title: Text(
//                     item.query,
//                     style: theme.textTheme.titleSmall,
//                   ),
//                   subtitle: Text(
//                     '${item.resultCount} results • ${item.formattedTimestamp}',
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: theme.colorScheme.onSurface.withOpacity(0.6),
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.north_west_rounded, size: 20),
//                     onPressed: () => _useHistoryItem(item),
//                     tooltip: 'Use this search',
//                   ),
//                   dense: true,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchResultCard(MaintenanceRequest request) {
//     final theme = Theme.of(context);

//     // Helper function to highlight matched text
//     Widget highlightText(String text, String query) {
//       if (query.isEmpty) return Text(text);

//       final lowerCaseText = text.toLowerCase();
//       final lowerCaseQuery = query.toLowerCase();

//       if (!lowerCaseText.contains(lowerCaseQuery)) {
//         return Text(
//           text,
//           style: theme.textTheme.bodyMedium,
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         );
//       }

//       final List<TextSpan> spans = [];
//       int start = 0;
//       int indexOfMatch;

//       while (true) {
//         indexOfMatch = lowerCaseText.indexOf(lowerCaseQuery, start);
//         if (indexOfMatch == -1) {
//           // No more matches
//           spans.add(TextSpan(text: text.substring(start)));
//           break;
//         }

//         if (indexOfMatch > start) {
//           // Add text before match
//           spans.add(TextSpan(text: text.substring(start, indexOfMatch)));
//         }

//         // Add highlighted match
//         spans.add(TextSpan(
//           text: text.substring(indexOfMatch, indexOfMatch + query.length),
//           style: TextStyle(
//             backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
//             fontWeight: FontWeight.bold,
//             color: theme.colorScheme.primary,
//           ),
//         ));

//         // Move start to end of match
//         start = indexOfMatch + query.length;

//         // If we've reached the end of text, break
//         if (start >= text.length) break;
//       }

//       return RichText(
//         text: TextSpan(
//           style: theme.textTheme.bodyMedium,
//           children: spans,
//         ),
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//       );
//     }

//     Color statusColor;
//     switch (request.status) {
//       case RequestStatus.submitted:
//       case RequestStatus.approved:
//         statusColor = Colors.blue;
//         break;
//       case RequestStatus.rejected:
//         statusColor = Colors.red;
//         break;
//       case RequestStatus.assigned:
//       case RequestStatus.inProgress:
//         statusColor = Colors.orange;
//         break;
//       case RequestStatus.onHold:
//         statusColor = Colors.amber;
//         break;
//       case RequestStatus.completed:
//       case RequestStatus.verified:
//         statusColor = Colors.green;
//         break;
//       default:
//         statusColor = Colors.grey;
//     }

//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(color: theme.colorScheme.outline.withOpacity(0.2)),
//       ),
//       child: InkWell(
//         onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => RequestDetailScreen(requestId: request.id),
//           ),
//         ).then((_) => setState(() {})),
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Status and date
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: statusColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           width: 8,
//                           height: 8,
//                           decoration: BoxDecoration(
//                             color: statusColor,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           request.statusText,
//                           style: theme.textTheme.bodySmall?.copyWith(
//                             color: statusColor,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     _formatDate(request.lastUpdated),
//                     style: theme.textTheme.bodySmall?.copyWith(
//                       color: theme.colorScheme.onSurface.withOpacity(0.6),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Title and description
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: theme.colorScheme.primary.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(
//                       _getCategoryIcon(request.category),
//                       color: theme.colorScheme.primary,
//                       size: 22,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Title with highlighting
//                         highlightText(request.title, _currentQuery),
//                         const SizedBox(height: 4),
//                         // Location with highlighting
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.location_on_rounded,
//                               size: 14,
//                               color:
//                                   theme.colorScheme.onSurface.withOpacity(0.6),
//                             ),
//                             const SizedBox(width: 4),
//                             Expanded(
//                               child: highlightText(
//                                   request.location, _currentQuery),
//                             ),
//                           ],
//                         ),
//                         // Description preview with highlighting (only if query matches)
//                         if (_currentQuery.isNotEmpty &&
//                             request.description
//                                 .toLowerCase()
//                                 .contains(_currentQuery.toLowerCase())) ...[
//                           const SizedBox(height: 8),
//                           highlightText(
//                             request.description,
//                             _currentQuery,
//                           ),
//                         ],
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               // Priority indicator
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color:
//                           _getPriorityColor(request.priority).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       _getPriorityName(request.priority),
//                       style: theme.textTheme.bodySmall?.copyWith(
//                         color: _getPriorityColor(request.priority),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),

//                   // Cost or assignment info
//                   if (request.cost != null) ...[
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade50,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.attach_money_rounded,
//                             size: 14,
//                             color: Colors.green.shade700,
//                           ),
//                           Text(
//                             request.cost!.toStringAsFixed(0),
//                             style: TextStyle(
//                               color: Colors.green.shade700,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ] else if (request.assignedTo != null) ...[
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.purple.shade50,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.business_rounded,
//                             size: 14,
//                             color: Colors.purple.shade700,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             'Assigned',
//                             style: TextStyle(
//                               color: Colors.purple.shade700,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime dateTime) {
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);

//     if (difference.inDays == 0) {
//       if (difference.inHours == 0) {
//         if (difference.inMinutes == 0) {
//           return 'Just now';
//         }
//         return '${difference.inMinutes}m ago';
//       }
//       return '${difference.inHours}h ago';
//     } else if (difference.inDays < 7) {
//       return '${difference.inDays}d ago';
//     } else {
//       return DateFormat('MMM d').format(dateTime);
//     }
//   }

//   String _getCategoryName(MaintenanceCategory category) {
//     switch (category) {
//       case MaintenanceCategory.electrical:
//         return 'Electrical';
//       case MaintenanceCategory.plumbing:
//         return 'Plumbing';
//       case MaintenanceCategory.cleaning:
//         return 'Cleaning';
//       case MaintenanceCategory.structural:
//         return 'Structural';
//       default:
//         return 'Other';
//     }
//   }

//   String _getStatusName(RequestStatus status) {
//     switch (status) {
//       case RequestStatus.submitted:
//         return 'Submitted';
//       case RequestStatus.approved:
//         return 'Approved';
//       case RequestStatus.rejected:
//         return 'Rejected';
//       case RequestStatus.assigned:
//         return 'Assigned';
//       case RequestStatus.inProgress:
//         return 'In Progress';
//       case RequestStatus.onHold:
//         return 'On Hold';
//       case RequestStatus.completed:
//         return 'Completed';
//       case RequestStatus.verified:
//         return 'Verified';
//       default:
//         return 'Unknown';
//     }
//   }

//   String _getPriorityName(Priority priority) {
//     switch (priority) {
//       case Priority.low:
//         return 'Low Priority';
//       case Priority.medium:
//         return 'Medium Priority';
//       case Priority.high:
//         return 'High Priority';
//       default:
//         return 'Medium Priority';
//     }
//   }

//   Color _getPriorityColor(Priority priority) {
//     switch (priority) {
//       case Priority.animation:
//         return Colors.green;
//       case Priority.idle:
//         return Colors.orange;
//       case Priority.touch:
//         return Colors.red;
//       default:
//         return Colors.orange;
//     }
//   }
// }
