import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panenin - Customer Service',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          displayLarge: TextStyle(fontFamily: 'Poppins'),
          displayMedium: TextStyle(fontFamily: 'Poppins'),
          displaySmall: TextStyle(fontFamily: 'Poppins'),
          headlineLarge: TextStyle(fontFamily: 'Poppins'),
          headlineMedium: TextStyle(fontFamily: 'Poppins'),
          headlineSmall: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins'),
          titleMedium: TextStyle(fontFamily: 'Poppins'),
          titleSmall: TextStyle(fontFamily: 'Poppins'),
          labelLarge: TextStyle(fontFamily: 'Poppins'),
          bodySmall: TextStyle(fontFamily: 'Poppins'),
          labelSmall: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      // Changed: Start with custserviceScreen (Pelayanan Pelanggan)
      home: custserviceScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatMessage {
  final String text;
  final bool isAgent;
  final String time;

  ChatMessage({
    required this.text,
    required this.isAgent,
    required this.time,
  });
}

// FIXED: This is now the main customer service landing page
class custserviceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: Colors.black),
          // FIXED: This now goes back to dashboard (will be handled by your main app)
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pelayanan Pelanggan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Layanan Bantuan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'Apa yang bisa kami bantu?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Iconsax.message_question,
                    label: 'Bantuan',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpScreen()),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Iconsax.call,
                    label: 'Kontak Kami',
                    onTap: () {
                      // Handle contact action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fitur kontak akan segera tersedia')),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Layanan Cepat',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16),
            _buildQuickServiceItem(
              context,
              icon: Iconsax.message,
              title: 'Chat Langsung dengan Agen',
              description: 'Dapatkan bantuan langsung dari tim customer service kami',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              ),
            ),
            _buildQuickServiceItem(
              context,
              icon: Iconsax.shopping_bag,
              title: 'Masalah Pesanan',
              description: 'Laporkan masalah terkait pesanan Anda',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              ),
            ),
            _buildQuickServiceItem(
              context,
              icon: Iconsax.card,
              title: 'Masalah Pembayaran',
              description: 'Bantuan untuk masalah pembayaran dan transaksi',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.grey[600]),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickServiceItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 24, color: Colors.green[700]),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            Icon(Iconsax.arrow_right_3, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

// FIXED: This is now the Help/Bantuan screen (second step)
class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: Colors.black),
          // FIXED: Goes back to Pelayanan Pelanggan
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Bantuan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bantuan Pengguna',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'Apa yang bisa kami bantu?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Iconsax.message,
                    label: 'Chat Agen',
                    // FIXED: Now navigates to ChatScreen
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Iconsax.call,
                    label: 'Kontak Kami',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Pertanyaan Populer (FAQs)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16),
            _buildFAQItem(
              icon: Iconsax.shopping_bag,
              title: 'Apa itu Panenin?',
              description: 'Panenin adalah aplikasi jual beli yang menghubungkan petani dengan pembeli secara langsung, dalam bentuk B2B. Di Panenin, petani bisa memasarkan hasil panennya tanpa perantara, dan pembeli bisa mendapatkan produk segar langsung dari sumbernya.',
            ),
            _buildFAQItem(
              icon: Iconsax.people,
              title: 'Apakah Panenin tersedia di daerah saya?',
              description: 'Panenin saat ini tersedia di beberapa kota tertentu. kamu bisa memasukkan lokasi kamu di aplikasi untuk melihat ketersediaan layanan di daerahmu. Kami terus memperluas jangkauan kami!',
            ),
            _buildFAQItem(
              icon: Iconsax.info_circle,
              title: 'Bagaimana jika ada masalah dengan pesanan saya?',
              description: 'Jika produk yang diterima rusak atau tidak sesuai, silakan hubungi layanan bantuan kami maksimal 24 jam setelah pesanan diterima. Kami akan membantu menyelesaikan masalah tersebut.',
            ),
            _buildFAQItem(
              icon: Iconsax.close_circle,
              title: 'Saya ingin membatalkan pesanan, bagaimana?',
              description: 'Pesanan bisa dibatalkan atau diubah selama statusnya belum diproses oleh petani. Silakan cek status pesanan di menu "Pesanan Saya" atau hubungi layanan bantuan kami.',
            ),
            SizedBox(height: 20),
            Text(
              'Pertanyaanmu belum terjawab?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'Silahkan chat Agen Pelayanan Pengguna kami!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // FIXED: Now navigates to ChatScreen instead of popping
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Mulai Chat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.grey[600]),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 24, color: Colors.green[700]),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// FIXED: This is now the ChatScreen (third step) - renamed from the original custserviceScreen
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = [
    ChatMessage(
      text: "Selamat siang, Pak Dedel Ada yang bisa kami bantu?",
      isAgent: true,
      time: "12:07",
    ),
    ChatMessage(
      text: "Saya ada masalah, sy udh bayar tp gk masuk* konfirmasiix.",
      isAgent: false,
      time: "12:08",
    ),
    ChatMessage(
      text: "Kami meminta maaf atas ketidaknyamanan yang Bapak alami.\nMohon kirimkan nomor pemesanan, kami akan selidiki dengan waktu maksimal 1x24 jam. Terima kasih!",
      isAgent: true,
      time: "12:08",
    ),
    ChatMessage(
      text: "nomor pemesanan ACD23894389AB239",
      isAgent: false,
      time: "12:08",
    ),
    ChatMessage(
      text: "Terima kasih atas informasinya.\nStatus pembayaran sudah kami validasi.",
      isAgent: true,
      time: "12:08",
    ),
    ChatMessage(
      text: "Y, trmksh ya.",
      isAgent: false,
      time: "12:08",
    ),
    ChatMessage(
      text: "Sama-sama! Apakah ada hal lain yang bisa kami bantu?",
      isAgent: true,
      time: "12:08",
    ),
    ChatMessage(
      text: "Sdh cukup, mksh ya, appnya bgus skli",
      isAgent: false,
      time: "12:08",
    ),
    ChatMessage(
      text: "Senang bisa membantu, pak Dedel\n-Agen Dudut",
      isAgent: true,
      time: "12:08",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: Colors.black),
          // FIXED: Goes back to HelpScreen (Bantuan)
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pesan - Agen Bantuan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.isAgent)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue[100],
              child: Icon(Iconsax.user, size: 18, color: Colors.blue[700]),
            ),
          if (message.isAgent) SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: message.isAgent
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                if (message.isAgent)
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Agen ${message.time}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: message.isAgent ? Colors.grey[100] : Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                if (!message.isAgent)
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      message.time + ' Anda',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!message.isAgent) SizedBox(width: 8),
          if (!message.isAgent)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green[100],
              child: Icon(Iconsax.user, size: 18, color: Colors.green[700]),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ketik Pesan...',
                hintStyle: TextStyle(fontFamily: 'Poppins'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: Icon(Iconsax.send1, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: _messageController.text,
          isAgent: false,
          time: "12:09", // You can implement proper time formatting here
        ));
      });
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}