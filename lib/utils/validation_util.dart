// lib/utils/validation_utils.dart
import 'package:flutter/services.dart';

class ValidationUtils {
  // Email validation
  static String? validateEmail(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your email';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value!)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your password';
    }
    
    if (value!.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    return null;
  }

  // Height validation (in cm)
  static String? validateHeight(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your height';
    }
    
    final height = int.tryParse(value!);
    if (height == null) {
      return 'Please enter a valid number';
    }
    
    if (height < 50 || height > 300) {
      return 'Please enter a realistic height (50-300 cm)';
    }
    
    return null;
  }

  // Weight validation (in kg)
  static String? validateWeight(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your weight';
    }
    
    final weight = double.tryParse(value!);
    if (weight == null) {
      return 'Please enter a valid number';
    }
    
    if (weight < 20 || weight > 500) {
      return 'Please enter a realistic weight (20-500 kg)';
    }
    
    return null;
  }

  // Target weight validation (optional field)
  static String? validateTargetWeight(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return null; // Optional field
    }
    
    final target = double.tryParse(value!);
    if (target == null) {
      return 'Please enter a valid number';
    }
    
    if (target < 20 || target > 500) {
      return 'Please enter a realistic weight (20-500 kg)';
    }
    
    return null;
  }

  // Age validation
  static String? validateAge(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your age';
    }
    
    final age = int.tryParse(value!);
    if (age == null) {
      return 'Please enter a valid number';
    }
    
    if (age < 10 || age > 120) {
      return 'Please enter a realistic age (10-120 years)';
    }
    
    return null;
  }

  // Username validation
  static String? validateUsername(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter a username';
    }
    
    if (value!.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    
    if (value.length > 20) {
      return 'Username must be less than 20 characters';
    }
    
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    
    return null;
  }

  // Name validation
  static String? validateName(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your name';
    }
    
    if (value!.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    
    if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }
    
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    
    return null;
  }

  // Generic required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  // Numeric validation with range
  static String? validateNumericRange(
    String? value, 
    String fieldName, 
    double min, 
    double max,
    {bool isRequired = true}
  ) {
    if (!isRequired && (value?.trim().isEmpty ?? true)) {
      return null;
    }
    
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter $fieldName';
    }
    
    final number = double.tryParse(value!);
    if (number == null) {
      return 'Please enter a valid number';
    }
    
    if (number < min || number > max) {
      return '$fieldName must be between $min and $max';
    }
    
    return null;
  }

  // Phone number validation (basic)
  static String? validatePhoneNumber(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your phone number';
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    if (!phoneRegex.hasMatch(value!)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }
}

// Input formatters for common use cases
class InputFormatters {
  // Only allow digits
  static final digitsOnly = FilteringTextInputFormatter.digitsOnly;
  
  // Allow digits and decimal point (for weight, height with decimals)
  static final decimalNumbers = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
  
  // Allow letters and spaces only (for names)
  static final lettersAndSpaces = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));
  
  // Allow alphanumeric and underscores (for usernames)
  static final alphanumericUnderscore = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]'));
  
  // Limit text length
  static LengthLimitingTextInputFormatter limitLength(int maxLength) {
    return LengthLimitingTextInputFormatter(maxLength);
  }
  
  // Custom formatter for phone numbers
  static final phoneNumber = FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-\(\)\+]'));
}

// Form validation helper class
class FormValidationHelper {
  final Map<String, String?> _errors = {};
  
  // Add validation error
  void addError(String field, String? error) {
    if (error != null) {
      _errors[field] = error;
    } else {
      _errors.remove(field);
    }
  }
  
  // Check if form has errors
  bool get hasErrors => _errors.isNotEmpty;
  
  // Get all errors
  Map<String, String> get errors => Map.from(_errors);
  
  // Get error for specific field
  String? getError(String field) => _errors[field];
  
  // Clear all errors
  void clearErrors() => _errors.clear();
  
  // Clear error for specific field
  void clearError(String field) => _errors.remove(field);
  
  // Validate multiple fields at once
  bool validateFields(Map<String, String? Function()> validators) {
    clearErrors();
    
    validators.forEach((field, validator) {
      final error = validator();
      if (error != null) {
        addError(field, error);
      }
    });
    
    return !hasErrors;
  }
}

// Validation result class
class ValidationResult {
  final bool isValid;
  final String? error;
  final dynamic value;
  
  const ValidationResult.valid(this.value) 
      : isValid = true, 
        error = null;
        
  const ValidationResult.invalid(this.error) 
      : isValid = false, 
        value = null;
}

// Async validation class for server-side validations
class AsyncValidation {
  static Future<ValidationResult> validateEmailExists(String email) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock validation - replace with actual API call
    if (email.toLowerCase() == 'existing@example.com') {
      return const ValidationResult.invalid('Email already exists');
    }
    
    return ValidationResult.valid(email);
  }
  
  static Future<ValidationResult> validateUsernameExists(String username) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Mock validation - replace with actual API call
    if (username.toLowerCase() == 'existinguser') {
      return const ValidationResult.invalid('Username already taken');
    }
    
    return ValidationResult.valid(username);
  }
}