import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// Models
class Product {
  final String id;
  final String name;
  final String weight;
  final String imageUrl;
  final bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.weight,
    required this.imageUrl,
    this.isAvailable = true,
  });
}

class NotificationSettings {
  final String productId;
  final String productName;
  final String category;
  final String plantingDate;
  final String harvestDate;
  final double minimumStock;
  final String unit;
  final String harvestPrediction;
  final String notes;

  NotificationSettings({
    required this.productId,
    required this.productName,
    required this.category,
    required this.plantingDate,
    required this.harvestDate,
    required this.minimumStock,
    required this.unit,
    required this.harvestPrediction,
    required this.notes,
  });
}

// Screen 1: Set Notification Main Screen
class StockNotificationScreen extends StatefulWidget {
  @override
  _StockNotificationScreenState createState() => _StockNotificationScreenState();
}

class _StockNotificationScreenState extends State<StockNotificationScreen> {
  List<Product> products = [
    Product(id: '1', name: 'Tomat Cawi', weight: '11 Kg', imageUrl: 'assets/image/tomato.jpg'),
    Product(id: '2', name: 'Wortel Berani', weight: '10 Kg', imageUrl: 'assets/image/carrot.jpg'),
    Product(id: '3', name: 'Terong Panguruman', weight: '50 Kg', imageUrl: 'assets/image/eggplant.jpg'),
    Product(id: '4', name: 'Jari Bahe', weight: '130 Kg', imageUrl: 'assets/image/ginger.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Atur Notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Dari Stok',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              'Atur notifikasi stok tidak',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),

            // Product Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(products[index]);
                },
              ),
            ),

            SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNewProductScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Batalkan',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNewProductScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6B8E23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Produk Baru',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StockFromExistingScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Product Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.weight,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AddNewProductScreen extends StatefulWidget {
  @override
  _AddNewProductScreenState createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _plantingDateController = TextEditingController();
  final _harvestPredictionController = TextEditingController();
  final _minimumStockController = TextEditingController();
  final _notesController = TextEditingController();

  String selectedCategory = 'Buah';
  String selectedUnit = 'Kg';

  List<String> categories = ['Buah', 'Sayur', 'Kacang-kacangan'];
  List<String> units = ['Kg', 'Gram', 'Ton'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tambah Produk',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Product Image
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle image selection
                    _showImagePicker();
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tambah Foto',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Category Selection
              Text(
                'Kategori Produk',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Pilih kategori produk',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 12),

              Row(
                children: categories.map((category) {
                  bool isSelected = selectedCategory == category;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFF6B8E23) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Color(0xFF6B8E23) : Colors.grey[300]!,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getCategoryIcon(category),
                              color: isSelected ? Colors.white : Colors.grey[600],
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),

              // Product Name
              Text(
                'Nama Produk',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  hintText: '12/100 karakter',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                maxLength: 100,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Description
              Text(
                'Deskripsi Produk',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Deskripsikan produk anda',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Deskripsi produk...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Planting Date
              Text(
                'Tanggal Tanam',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _plantingDateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'HH/BB/TT',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                onTap: () => _selectDate(context, _plantingDateController),
              ),
              SizedBox(height: 8),
              Text(
                'Waktu yang dibutuhkan dari tanggal hingga panen',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),

              // Harvest Prediction
              Text(
                'Prediksi Tanggal Panen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _harvestPredictionController,
                decoration: InputDecoration(
                  hintText: 'HH/BB/TTTT',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Minimum Stock
              Text(
                'Kuantitas Minimum Pemesanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _minimumStockController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0.5',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kuantitas tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedUnit,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      items: units.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedUnit = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Harvest Date
              Text(
                'Tanggal Panen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        '02/06/2025',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Stock Consumption
              Text(
                'Baik Dikonsumsi Sebelum',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _buildTimeButton('Hari', true),
                  SizedBox(width: 8),
                  _buildTimeButton('Bulan', false),
                  SizedBox(width: 8),
                  _buildTimeButton('Tahun', false),
                ],
              ),
              SizedBox(height: 16),

              // Storage Notes
              Text(
                'Penyimpanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tambahkan #',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
              Text(
                'Bagaimana produk disimpan',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[400]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Batalkan',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveProduct,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6B8E23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeButton(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF6B8E23) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Color(0xFF6B8E23) : Colors.grey[300]!,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Buah':
        return Icons.apple;
      case 'Sayur':
        return Icons.grass;
      case 'Kacang-kacangan':
        return Icons.grain;
      default:
        return Icons.category;
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Ambil Foto'),
              onTap: () {
                Navigator.pop(context);
                // Handle camera
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(context);
                // Handle gallery
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // Handle save product
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produk berhasil disimpan!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _plantingDateController.dispose();
    _harvestPredictionController.dispose();
    _minimumStockController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}

// Screen 3: Stock From Existing Product
class StockFromExistingScreen extends StatefulWidget {
  final Product product;

  const StockFromExistingScreen({Key? key, required this.product}) : super(key: key);

  @override
  _StockFromExistingScreenState createState() => _StockFromExistingScreenState();
}

class _StockFromExistingScreenState extends State<StockFromExistingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plantingDateController = TextEditingController();
  final _harvestDateController = TextEditingController();
  final _minimumStockController = TextEditingController();
  final _notesController = TextEditingController();

  String selectedCategory = 'Buah';
  String selectedUnit = 'Kg';
  String selectedTimeframe = 'Hari';

  List<String> categories = ['Buah', 'Sayur', 'Kacang-kacangan'];
  List<String> units = ['Kg', 'Gram', 'Ton'];
  List<String> timeframes = ['Hari', 'Bulan', 'Tahun'];

  @override
  void initState() {
    super.initState();
    _harvestDateController.text = '02/06/2025';
    _minimumStockController.text = '0.5';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tambah Produk',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image and Info
              // stock_notification_screens.dart (continuation)
              // Product Image and Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Product Image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          widget.product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    // Product Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.product.weight,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Category Selection
              Text(
                'Kategori Produk',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Pilih kategori produk',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 12),

              Row(
                children: categories.map((category) {
                  bool isSelected = selectedCategory == category;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFF6B8E23) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Color(0xFF6B8E23) : Colors.grey[300]!,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getCategoryIcon(category),
                              color: isSelected ? Colors.white : Colors.grey[600],
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey[700],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 24),

              // Planting Date
              Text(
                'Tanggal Tanam',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _plantingDateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'HH/BB/TT',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                onTap: () => _selectDate(context, _plantingDateController),
              ),
              SizedBox(height: 8),
              Text(
                'Waktu yang diperlukan dari tanggal hingga panen',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),

              // Harvest Date
              Text(
                'Tanggal Panen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _harvestDateController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                onTap: () => _selectDate(context, _harvestDateController),
              ),
              SizedBox(height: 16),

              // Minimum Stock
              Text(
                'Kuantitas Minimum Pemesanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _minimumStockController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kuantitas tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedUnit,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      items: units.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedUnit = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Stock Consumption
              Text(
                'Baik Dikonsumsi Sebelum',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: timeframes.map((timeframe) {
                  bool isSelected = selectedTimeframe == timeframe;
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTimeframe = timeframe;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFF6B8E23) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? Color(0xFF6B8E23) : Colors.grey[300]!,
                          ),
                        ),
                        child: Text(
                          timeframe,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // Storage Notes
              Text(
                'Penyimpanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Bagaimana produk disimpan',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tambahkan #',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
              ),
              SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[400]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Batalkan',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveNotificationSettings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6B8E23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Buah':
        return Icons.apple;
      case 'Sayur':
        return Icons.grass;
      case 'Kacang-kacangan':
        return Icons.grain;
      default:
        return Icons.category;
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void _saveNotificationSettings() {
    if (_formKey.currentState!.validate()) {
      // Create notification settings object
      NotificationSettings settings = NotificationSettings(
        productId: widget.product.id,
        productName: widget.product.name,
        category: selectedCategory,
        plantingDate: _plantingDateController.text,
        harvestDate: _harvestDateController.text,
        minimumStock: double.tryParse(_minimumStockController.text) ?? 0.0,
        unit: selectedUnit,
        harvestPrediction: selectedTimeframe,
        notes: _notesController.text,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notifikasi stok berhasil diatur!'),
          backgroundColor: Color(0xFF6B8E23),
        ),
      );

      // Navigate back to main screen
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    _plantingDateController.dispose();
    _harvestDateController.dispose();
    _minimumStockController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}