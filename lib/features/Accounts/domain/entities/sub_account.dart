class SubAccountModel {
  final String id;
  final String name;
  final int mainAccountId; // يشير إلى MainAccountModel.id
  final String type; // مثل: client, supplier, موردين, مصروفات, tax
  final double totalBalance;
  final DateTime createdAt;
  final String? description;

  const SubAccountModel({
    required this.id,
    required this.name,
    required this.mainAccountId,
    required this.type,
    required this.totalBalance,
    required this.createdAt,
    this.description,
  });
}
 final List<SubAccountModel>  subAccounts = [
  SubAccountModel(
    id: '1',
    name: 'مصروفات بيت',
    mainAccountId: 3,
    type: 'موردين',
    totalBalance: -1200,
    createdAt: DateTime.now().subtract(Duration(days: 10)),
    description: 'مصاريف المنزل الشهريّة',
  ),
  SubAccountModel(
    id: '2',
    name: 'العميل محمد',
    mainAccountId: 2,
    type: 'العملاء',
    totalBalance: 5000,
    createdAt: DateTime.now().subtract(Duration(days: 3)),
  ),
  SubAccountModel(
    id: '3',
    name: 'ادخار طوارئ',
    mainAccountId: 4,
    type: 'مصروفات',
    totalBalance: 2500,
    createdAt: DateTime.now().subtract(Duration(days: 25)),
  ),
  SubAccountModel(
    id: '4',
    name: 'مصروفات عمل',
    mainAccountId: 2,
    type: 'موردين',
    totalBalance: -500,
    createdAt: DateTime.now().subtract(Duration(days: 5)),
  ),
  SubAccountModel(
    id: '5',
    name: 'مصروفات عمل',
    mainAccountId: 2,
    type: 'موردين',
    totalBalance: -500,
    createdAt: DateTime.now().subtract(Duration(days: 5)),
  ),
  SubAccountModel(
    id: '6',
    name: 'مصروفات عمل',
    mainAccountId: 2,
    type: 'موردين',
    totalBalance: -500,
    createdAt: DateTime.now().subtract(Duration(days: 5)),
  ),
  SubAccountModel(
    id: '7',
    name: 'مصروفات شغل',
    mainAccountId: 2,
    type: 'موردين',
    totalBalance: -500,
    createdAt: DateTime.now().subtract(Duration(days: 5)),
  ),
  
];
