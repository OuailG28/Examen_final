<<<<<<< HEAD
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  List<User> _users = [];
  bool _rememberMe = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get rememberMe => _rememberMe;

  AuthService() {
    _loadUsers();
    _autoLogin();
  }

<<<<<<< HEAD
 
=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  Future<void> _autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('saved_username');
    final savedPassword = prefs.getString('saved_password');
    final rememberMe = prefs.getBool('remember_me') ?? false;

    if (rememberMe && savedUsername != null && savedPassword != null) {
      await login(savedUsername, savedPassword, rememberMe: true);
    }
  }

<<<<<<< HEAD
  
=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  String? validateEmail(String email) {
    if (email.isEmpty) return 'L\'email ne peut pas être vide';

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Format d\'email invalide';
    }
    return null;
  }

<<<<<<< HEAD
  
=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  String? validatePassword(String password) {
    if (password.isEmpty) return 'Le mot de passe ne peut pas être vide';
    if (password.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Le mot de passe doit contenir au moins une majuscule';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Le mot de passe doit contenir au moins un chiffre';
    }
    return null;
  }

<<<<<<< HEAD
  
=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  String? validateUsername(String username) {
    if (username.isEmpty) return 'Le nom d\'utilisateur ne peut pas être vide';
    if (username.length < 3) {
      return 'Le nom d\'utilisateur doit contenir au moins 3 caractères';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return 'Le nom d\'utilisateur ne peut contenir que des lettres, chiffres et underscores';
    }
    return null;
  }

  Future<String?> updateProfile(String newEmail, String? newPassword) async {
    if (_currentUser == null) return 'Utilisateur non connecté';

<<<<<<< HEAD
    
    final emailError = validateEmail(newEmail);
    if (emailError != null) return emailError;

    
=======
    final emailError = validateEmail(newEmail);
    if (emailError != null) return emailError;

>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
    if (_users.any(
      (u) => u.email == newEmail && u.username != _currentUser!.username,
    )) {
      return 'Cet email est déjà utilisé';
    }

<<<<<<< HEAD

=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
    if (newPassword != null && newPassword.isNotEmpty) {
      final passwordError = validatePassword(newPassword);
      if (passwordError != null) return passwordError;
    }

<<<<<<< HEAD

=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
    _users = _users.map((u) {
      if (u.username == _currentUser!.username) {
        return User(
          username: u.username,
          email: newEmail,
          password: newPassword != null && newPassword.isNotEmpty
              ? newPassword
              : u.password,
        );
      }
      return u;
    }).toList();

<<<<<<< HEAD
    
=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
    _currentUser = User(
      username: _currentUser!.username,
      email: newEmail,
      password: newPassword != null && newPassword.isNotEmpty
          ? newPassword
          : _currentUser!.password,
    );

    await _saveUsers();

<<<<<<< HEAD
    
=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
    if (_rememberMe && newPassword != null && newPassword.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_password', newPassword);
    }

    notifyListeners();
    return null;
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList('users') ?? [];
    _users = usersJson.map((json) => User.fromJson(jsonDecode(json))).toList();

<<<<<<< HEAD

=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
    if (_users.isEmpty) {
      _users.add(
        User(username: 'demo', email: 'demo@example.com', password: 'Demo123'),
      );
      await _saveUsers();
    }
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = _users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList('users', usersJson);
  }

<<<<<<< HEAD

=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  Future<bool> login(
    String username,
    String password, {
    bool rememberMe = false,
  }) async {
    final user = _users.firstWhere(
      (u) => u.username == username && u.password == password,
      orElse: () => User(username: '', email: '', password: ''),
    );

    if (user.username.isNotEmpty) {
      _currentUser = user;
      _rememberMe = rememberMe;

<<<<<<< HEAD

=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
      final prefs = await SharedPreferences.getInstance();
      if (rememberMe) {
        await prefs.setString('saved_username', username);
        await prefs.setString('saved_password', password);
        await prefs.setBool('remember_me', true);
      } else {
        await prefs.remove('saved_username');
        await prefs.remove('saved_password');
        await prefs.setBool('remember_me', false);
      }

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
<<<<<<< HEAD
    
    final usernameError = validateUsername(username);
    if (usernameError != null) return usernameError;

    
    final emailError = validateEmail(email);
    if (emailError != null) return emailError;

    
    final passwordError = validatePassword(password);
    if (passwordError != null) return passwordError;

    
=======
    final usernameError = validateUsername(username);
    if (usernameError != null) return usernameError;

    final emailError = validateEmail(email);
    if (emailError != null) return emailError;

    final passwordError = validatePassword(password);
    if (passwordError != null) return passwordError;

>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
    if (_users.any((u) => u.username == username)) {
      return 'Ce nom d\'utilisateur existe déjà';
    }
    if (_users.any((u) => u.email == email)) {
      return 'Cet email est déjà utilisé';
    }

    final newUser = User(username: username, email: email, password: password);
    _users.add(newUser);
    await _saveUsers();
    return null;
  }

<<<<<<< HEAD
  
=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  Future<String?> resetPassword(String email) async {
    final user = _users.firstWhere(
      (u) => u.email == email,
      orElse: () => User(username: '', email: '', password: ''),
    );

    if (user.email.isEmpty) {
      return 'Aucun compte associé à cet email';
    }

<<<<<<< HEAD
    
    return null; 
=======
    return null;
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  }

  void logout() {
    _currentUser = null;
    _rememberMe = false;
    notifyListeners();
  }

<<<<<<< HEAD

=======
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  Future<String?> deleteAccount(String password) async {
    if (_currentUser == null) return 'Utilisateur non connecté';

    if (_currentUser!.password != password) {
      return 'Mot de passe incorrect';
    }

    _users.removeWhere((u) => u.username == _currentUser!.username);
    await _saveUsers();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_username');
    await prefs.remove('saved_password');
    await prefs.setBool('remember_me', false);

    _currentUser = null;
    _rememberMe = false;
    notifyListeners();

<<<<<<< HEAD
    return null; 
=======
    return null;
>>>>>>> 0a39d933e816449316ec0b437e93091ff5e31364
  }
}
=======
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  List<User> _users = [];

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  AuthService() {
    _loadUsers();
  }

  Future<String?> updateProfile(String newEmail, String? newPassword) async {
    if (_currentUser == null) return 'Utilisateur non connecté';

    if (_users.any(
      (u) => u.email == newEmail && u.username != _currentUser!.username,
    )) {
      return 'Cet email est déjà utilisé';
    }

    if (newPassword != null &&
        newPassword.isNotEmpty &&
        newPassword.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }

    _users = _users.map((u) {
      if (u.username == _currentUser!.username) {
        return User(
          username: u.username,
          email: newEmail,
          password: newPassword != null && newPassword.isNotEmpty
              ? newPassword
              : u.password,
        );
      }
      return u;
    }).toList();

    _currentUser = User(
      username: _currentUser!.username,
      email: newEmail,
      password: newPassword != null && newPassword.isNotEmpty
          ? newPassword
          : _currentUser!.password,
    );

    await _saveUsers();
    notifyListeners();
    return null;
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList('users') ?? [];
    _users = usersJson.map((json) => User.fromJson(jsonDecode(json))).toList();

    if (_users.isEmpty) {
      _users.add(
        User(username: 'demo', email: 'demo@example.com', password: 'demo123'),
      );
      await _saveUsers();
    }
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = _users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList('users', usersJson);
  }

  Future<bool> login(String username, String password) async {
    final user = _users.firstWhere(
      (u) => u.username == username && u.password == password,
      orElse: () => User(username: '', email: '', password: ''),
    );

    if (user.username.isNotEmpty) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    if (_users.any((u) => u.username == username)) {
      return 'Ce nom d\'utilisateur existe déjà';
    }
    if (_users.any((u) => u.email == email)) {
      return 'Cet email est déjà utilisé';
    }
    if (password.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }

    final newUser = User(username: username, email: email, password: password);
    _users.add(newUser);
    await _saveUsers();
    return null;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
>>>>>>> 538c791 (finalisation de l'app par ouail)
