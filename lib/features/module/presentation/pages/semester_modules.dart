import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/features/module/domain/entities/module.dart';
import 'package:gpa_calculator/features/module/domain/usecases/module_handlers.dart';
import 'package:gpa_calculator/features/module/presentation/pages/add_module_page.dart';

class SemesterModulesPage extends StatefulWidget {
  final Map<dynamic, int> map;

  const SemesterModulesPage(this.map, {Key? key}) : super(key: key);

  @override
  _SemesterModulesPageState createState() => _SemesterModulesPageState();
}

class _SemesterModulesPageState extends State<SemesterModulesPage> {
  List<ModuleEntity> modules = [];
  int semesterId = 0;
  final moduleHandlers = ModuleHandlers();

  @override
  void initState() {
    super.initState();
    semesterId = widget.map["semesterId"]!;
    _loadModules();
  }

  void _loadModules() async {
    final loadedModules = await moduleHandlers.handleGetModules(semesterId);
    setState(() {
      modules = loadedModules;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Semester Modules',
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: modules.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddButton(context);
          } else {
            return _buildModuleCard(context, modules[index - 1]);
          }
        },
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, ModuleEntity module) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(module.moduleName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Grade: ${module.grade}'),
            Text('Credit: ${module.credit}'),
            Text(module.isGpa == 1 ? 'GPA Module' : 'Non-GPA Module'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.blue[900],
              onPressed: () {
                _editModule(context, module);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red[900],
              onPressed: () {
                _deleteModule(context, module);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddModulePage({"semesterId": semesterId}),
            ),
          );
          if (result == true) {
            _loadModules();
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Module',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              Icon(Icons.add_box_rounded),
            ],
          ),
        ),
      ),
    );
  }

  void _editModule(BuildContext context, ModuleEntity module) {}

  void _deleteModule(BuildContext context, ModuleEntity module) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ${module.moduleName}?'),
          content: Text('Are you sure you want to delete this module?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                moduleHandlers.handleDeleteModule(module.id!);
                _loadModules();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
