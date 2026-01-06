import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  // Base de connaissances sur le PFE
  final Map<String, String> _knowledgeBase = {
    'titre': 'Création d\'une application mobile pour la Découverte des Beaux Endroits des Villes du Maroc',
    'laravel': 'Laravel a été choisi comme framework backend pour ce projet. C\'est un framework PHP moderne qui offre une architecture MVC, une excellente gestion des bases de données, et de nombreuses fonctionnalités intégrées.',
    'react': 'React a été utilisé pour le développement frontend de l\'application. C\'est une bibliothèque JavaScript moderne qui permet de créer des interfaces utilisateur interactives et réactives.',
    'tailwind': 'Tailwind CSS a été utilisé pour le styling de l\'application. C\'est un framework CSS utilitaire qui permet de créer des designs modernes et responsives rapidement.',
    'architecture': 'L\'architecture de l\'application suit le modèle MVC (Model-View-Controller). Le backend utilise Laravel avec une API REST, tandis que le frontend utilise React pour l\'interface utilisateur.',
    'diagramme': 'Le projet inclut plusieurs diagrammes : diagramme de classe, diagramme de cas d\'utilisation, et diagramme de séquence. Ces diagrammes aident à visualiser la structure et le comportement de l\'application.',
    'tests': 'Des tests de sécurité ont été appliqués pour vérifier la robustesse de l\'authentification, la validation des entrées et la protection contre les attaques XSS et CSRF, validant ainsi la stabilité et la performance globale de l\'application avant sa mise en production.',
    'conclusion': 'Des tests de sécurité ont été appliqués pour vérifier la robustesse de l’authentification, la validation des entrées et la protection contre les attaques XSS et CSRF, validant ainsi la stabilité et la performance globale de l’application avant sa mise en production. \n Conclusion:Ce projet d’application de découverte des villes marocaines répond à un besoin réel du marché touristique en proposant une solution complète et moderne. L’utilisation de technologies contemporaines (React, Laravel, Tailwind CSS) garantit une expérience utilisateur optimale et une maintenance ais...',
    'maroc': 'Le Maroc est un pays riche en diversité culturelle, historique et géographique. L\'application permet de découvrir les beaux endroits des différentes villes marocaines.',
    'base de données': 'L\'intégration de la base de données et de l\'API permet de stocker et récupérer les informations sur les villes et les lieux d\'intérêt. Laravel facilite cette intégration avec son ORM Eloquent.',
    'cahier des charges': 'Le cahier des charges fonctionnel et technique définit les exigences et spécifications du projet, incluant les fonctionnalités, les contraintes techniques, et les objectifs à atteindre.',
  };

  @override
  void initState() {
    super.initState();
    _addInitialMessage();
  }

  void _addInitialMessage() {
    setState(() {
      _messages.add(ChatMessage(
        text: 'Bonjour ! \n Sur quelle partie du document souhaitez-vous de \n l\'aide?\n'
            '- Choix de Laravel\n'
            '- Cahier des charges (fonctionnel/technique)\n'
            '- Architecture de l\'application\n'
            '- Diagrammes (classe, cas d\'utilisation, séquence)\n'
            '- Développement de l\'application\n'
            '- Tests et validation\n'
            '- Conclusion\n'
            '- Bibliographie et Références\n'
            '- Explication/fonctionnalités de chaque page\n'
            '- Outils et environnements utilisés\n'
            '- Intégration base de données / API\n'
            ,
        isUser: false,
      ));
    });
  }

  String _findAnswer(String question) {
    final lowerQuestion = question.toLowerCase();
    
    // Recherche par mots-clés
    for (var entry in _knowledgeBase.entries) {
      final keywords = entry.key.split(' ');
      if (keywords.any((keyword) => lowerQuestion.contains(keyword))) {
        return entry.value;
      }
    }
    
    // Recherche spécifique pour certaines questions
    if (lowerQuestion.contains('titre') || lowerQuestion.contains('pfe')) {
      return _knowledgeBase['titre']!;
    }
    
    if (lowerQuestion.contains('technologie') || lowerQuestion.contains('stack')) {
      return 'Les technologies utilisées dans ce projet sont : React pour le frontend, Laravel pour le backend, et Tailwind CSS pour le styling.';
    }
    
    if (lowerQuestion.contains('sécurité') || lowerQuestion.contains('test')) {
      return _knowledgeBase['tests']!;
    }
    
    // Aucune information pertinente trouvée
    return 'Aucune information pertinente n\'a été trouvée dans les documents disponibles';
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text.trim();
    setState(() {
      _messages.add(ChatMessage(text: userMessage, isUser: true));
    });

    _messageController.clear();

    // Simuler une réponse après un court délai
    Future.delayed(const Duration(milliseconds: 500), () {
      final answer = _findAnswer(userMessage);
      setState(() {
        _messages.add(ChatMessage(text: answer, isUser: false));
      });
      _scrollToBottom();
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot RAG'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Écrire un message...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
