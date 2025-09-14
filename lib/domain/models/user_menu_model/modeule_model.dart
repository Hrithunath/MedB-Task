


class ModuleModel {
  final int moduleId;
  final String moduleName;
  final int sortOrder;
  final String? moduleIcon;
  final List<MenuItemModel> menus;

  ModuleModel({
    required this.moduleId,
    required this.moduleName,
    required this.sortOrder,
    this.moduleIcon,
    required this.menus,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      moduleId: json['moduleId'],
      moduleName: json['moduleName'],
      sortOrder: json['sortOrder'],
      moduleIcon: json['moduleIcon'],
      menus: (json['menus'] as List)
          .map((menu) => MenuItemModel.fromJson(menu))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'moduleId': moduleId,
        'moduleName': moduleName,
        'sortOrder': sortOrder,
        'moduleIcon': moduleIcon,
        'menus': menus.map((e) => e.toJson()).toList(),
      };
}
class MenuItemModel {
  final int menuId;
  final String menuName;
  final int sortOrder;
  final String? menuIcon;
  final String? actionName;
  final String? controllerName;

  MenuItemModel({
    required this.menuId,
    required this.menuName,
    required this.sortOrder,
    this.menuIcon,
    this.actionName,
    this.controllerName,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      menuId: json['menuId'],
      menuName: json['menuName'],
      sortOrder: json['sortOrder'],
      menuIcon: json['menuIcon'],
      actionName: json['actionName'],
      controllerName: json['controllerName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'menuId': menuId,
        'menuName': menuName,
        'sortOrder': sortOrder,
        'menuIcon': menuIcon,
        'actionName': actionName,
        'controllerName': controllerName,
      };
}
