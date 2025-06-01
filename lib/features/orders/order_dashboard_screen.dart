
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderDashboardScreen extends StatefulWidget {
  const OrderDashboardScreen({super.key});

  @override
  State<OrderDashboardScreen> createState() => _OrderDashboardScreenState();
}

class _OrderDashboardScreenState extends State<OrderDashboardScreen> {
  int selectedEntries = 10;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {
        "id": "#20462",
        "product": "Tomat",
        "jumlah": "5",
        "customer": "Andi",
        "tanggal": "30 Mei 2025",
        "total": "Rp25.000",
        "pembayaran": "Transfer",
        "status": "Selesai"
      },
      {
        "id": "#18933",
        "product": "Beras",
        "jumlah": "10",
        "customer": "Budi",
        "tanggal": "29 Mei 2025",
        "total": "Rp100.000",
        "pembayaran": "COD",
        "status": "Selesai"
      },
      {
        "id": "#45169",
        "product": "Beras Jepang",
        "jumlah": "3",
        "customer": "Cici",
        "tanggal": "28 Mei 2025",
        "total": "Rp90.000",
        "pembayaran": "Transfer",
        "status": "Diproses"
      },
      {
        "id": "#34304",
        "product": "Lobak",
        "jumlah": "4",
        "customer": "Doni",
        "tanggal": "27 Mei 2025",
        "total": "Rp20.000",
        "pembayaran": "QRIS",
        "status": "Diproses"
      },
      {
        "id": "#17188",
        "product": "Rambutan",
        "jumlah": "7",
        "customer": "Eka",
        "tanggal": "26 Mei 2025",
        "total": "Rp35.000",
        "pembayaran": "Transfer",
        "status": "Dibatalkan"
      },
      {
        "id": "#73003",
        "product": "Cabai Rawit",
        "jumlah": "2",
        "customer": "Fajar",
        "tanggal": "25 Mei 2025",
        "total": "Rp15.000",
        "pembayaran": "COD",
        "status": "Selesai"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Pesanan',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Statistik
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF3C5232),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildStatusBox("10", "Masuk"),
                  buildStatusBox("7", "Diproses"),
                  buildStatusBox("17", "Selesai"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown + Search + Add Button
            Row(
              children: [
                Row(
                  children: [
                    const Text(
                      "Tunjukkan ",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<int>(
                        value: selectedEntries,
                        items: [10, 20, 50]
                            .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Text(
                            "$e",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedEntries = value!;
                          });
                        },
                        underline: Container(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      " entri",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari...',
                      hintStyle: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: const Icon(Iconsax.search_normal),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Iconsax.add, color: Colors.black),
                  label: const Text(
                    "Add Customer",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF3C5232)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tabel scrollable
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    // Header
                    Row(
                      children: const [
                        TableHeader("Tracking ID"),
                        TableHeader("Produk"),
                        TableHeader("Jumlah"),
                        TableHeader("Customer"),
                        TableHeader("Tanggal"),
                        TableHeader("Total"),
                        TableHeader("Mode Pembayaran"),
                        TableHeader("Status"),
                        TableHeader("Aksi"),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Isi tabel
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: orders.asMap().entries.map((entry) {
                            int index = entry.key;
                            var order = entry.value;
                            final isEven = index % 2 == 0;

                            return Container(
                              color: isEven
                                  ? const Color(0xFFE7EAE2)
                                  : Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  TableCellText(order["id"] ?? ""),
                                  TableCellText(order["product"] ?? ""),
                                  TableCellText(order["jumlah"] ?? ""),
                                  TableCellText(order["customer"] ?? ""),
                                  TableCellText(order["tanggal"] ?? ""),
                                  TableCellText(order["total"] ?? ""),
                                  TableCellText(order["pembayaran"] ?? ""),
                                  TableCell(child: buildStatusBadge(order["status"] ?? "")),
                                  TableCell(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Iconsax.edit, color: Color(0xFF88541E)),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(Iconsax.trash, color: Color(0xFF981616)),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
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

  Widget buildStatusBox(String count, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F8F0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case "selesai":
        bgColor = const Color(0xFFDFF5E7);
        textColor = const Color(0xFF268C54);
        break;
      case "diproses":
        bgColor = const Color(0xFFFFF2E0);
        textColor = const Color(0xFFCC7A00);
        break;
      case "dibatalkan":
        bgColor = const Color(0xFFFFE4E4);
        textColor = const Color(0xFFD93025);
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  final String title;
  const TableHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TableCellText extends StatelessWidget {
  final String value;
  const TableCellText(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  final Widget child;
  const TableCell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(child: child),
    );
  }
}
