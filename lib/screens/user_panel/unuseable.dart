/*class AllcategoriesScreen extends StatefulWidget {
  const AllcategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AllcategoriesScreen> createState() => _AllcategoriesScreenState();
}

class _AllcategoriesScreenState extends State<AllcategoriesScreen> {
  late List<CategoriesModel> _categories;
  late List<CategoriesModel> _filteredCategories;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categories = [];
    _filteredCategories = [];
    fetchCategories();
  }

  void fetchCategories() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('catageries').get();
    List<CategoriesModel> categories = snapshot.docs.map((doc) {
      return CategoriesModel(
        categoryId: doc['categoryId'],
        catagoryImag: doc['catagoryImag'],
        catagoryName: doc['catagoryName'],
        createdAt: doc['createdAt'],
        updateAt: doc['updateAt'],
      );
    }).toList();

    setState(() {
      _categories = categories;
      _filteredCategories = categories;
    });
  }

  void filterCategories(String query) {
    List<CategoriesModel> filteredList = _categories.where((category) {
      return category.catagoryName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredCategories = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgruond1), fit: BoxFit.fill)),
        ),
        title: Align(
          alignment: Alignment.center,
          child: TextField(
            controller: _searchController,
            onChanged: (query) {
              filterCategories(query);
            },
            decoration: InputDecoration(
              hintText: 'Search Categories',
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: _filteredCategories.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          childAspectRatio: 1.19,
        ),
        itemBuilder: (context, index) {
          CategoriesModel category = _filteredCategories[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => AllsingleCategoriesproductScreen(
                  categoryId: category.categoryId));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FillImageCard(
                borderRadius: 20.0,
                width: Get.width / 2.4,
                heightImage: Get.height / 10,
                imageProvider: CachedNetworkImageProvider(category.catagoryImag),
                title: Center(
                  child: Text(
                    category.catagoryName,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

*/


