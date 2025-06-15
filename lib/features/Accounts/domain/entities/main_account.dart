class MainAccountModel {
  final int id;
  final String name;
  final double totalBalance;

  const MainAccountModel({
    required this.id,
    required this.name,
    required this.totalBalance,
  });
}
final List<MainAccountModel> mainAccounts = [
  MainAccountModel(id: 1, name: 'شخصي', totalBalance: 3500.0),
  MainAccountModel(id: 2, name: 'عمل', totalBalance: 12500.0),
  MainAccountModel(id: 3, name: 'عائلي', totalBalance: 4300.0),
  MainAccountModel(id: 4, name: 'ادخار', totalBalance: 9200.0),
];