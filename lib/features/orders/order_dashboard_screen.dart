import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderDashboardScreen extends StatefulWidget {
  const OrderDashboardScreen({super.key});

  @override
  State<OrderDashboardScreen> createState() => _OrderDashboardScreenState();
}

class _OrderDashboardScreenState extends State<OrderDashboardScreen> {
  int selectedEntries = 10;
  String selectedFilter = "Semua"; // Filter for order status

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

    // Filter orders based on selected filter
    List<Map<String, String>> filteredOrders = selectedFilter == "Semua"
        ? orders
        : orders.where((order) => order["status"] == selectedFilter).toList();

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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Compact Statistics
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF3C5232),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCompactStatusBox("10", "Masuk"),
                  buildCompactStatusBox("7", "Diproses"),
                  buildCompactStatusBox("17", "Selesai"),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Compact Controls
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cari pesanan...',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(Iconsax.search_normal, size: 20),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(6),
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
                              fontSize: 12,
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
                  ],
                ),
                const SizedBox(height: 8),

                // Status Filter Buttons
                Row(
                  children: [
                    buildFilterChip("Semua"),
                    const SizedBox(width: 6),
                    buildFilterChip("Selesai"),
                    const SizedBox(width: 6),
                    buildFilterChip("Diproses"),
                    const SizedBox(width: 6),
                    buildFilterChip("Dibatalkan"),
                  ],
                ),
                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.add, color: Colors.black, size: 18),
                    label: const Text(
                      "Tambah Customer",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF3C5232)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Card-based Order List (replacing table)
            Expanded(
              child: ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order["id"] ?? "",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              buildStatusBadge(order["status"] ?? ""),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Product and customer
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order["product"] ?? "",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      "Qty: ${order["jumlah"]} • ${order["customer"]}",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                order["total"] ?? "",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Color(0xFF3C5232),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Bottom row with date, payment, and actions
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order["tanggal"] ?? "",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      order["pembayaran"] ?? "",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Iconsax.edit, color: Color(0xFF88541E), size: 18),
                                    onPressed: () {},
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                    padding: EdgeInsets.zero,
                                  ),
                                  IconButton(
                                    icon: const Icon(Iconsax.trash, color: Color(0xFF981616), size: 18),
                                    onPressed: () {},
                                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterChip(String filter) {
    final bool isSelected = selectedFilter == filter;

    Color getChipColor() {
      if (!isSelected) return Colors.grey.shade200;

      switch (filter) {
        case "Selesai":
          return const Color(0xFFDFF5E7);
        case "Diproses":
          return const Color(0xFFFFF2E0);
        case "Dibatalkan":
          return const Color(0xFFFFE4E4);
        default:
          return const Color(0xFF3C5232);
      }
    }

    Color getTextColor() {
      if (!isSelected) return Colors.grey.shade700;

      switch (filter) {
        case "Selesai":
          return const Color(0xFF268C54);
        case "Diproses":
          return const Color(0xFFCC7A00);
        case "Dibatalkan":
          return const Color(0xFFD93025);
        default:
          return Colors.white;
      }
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = filter;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: getChipColor(),
            borderRadius: BorderRadius.circular(6),
            border: isSelected ? null : Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            filter,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: getTextColor(),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCompactStatusBox(String count, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F8F0),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          fontSize: 10,
        ),
      ),
    );
  }
}