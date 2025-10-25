# Admin Login Test Guide

## 🧪 **Testing Admin Login Functionality**

### ✅ **Test Cases**

#### Test 1: Primary Admin Credentials
1. Open the app
2. Navigate to login screen
3. Enter credentials:
   - **Email**: admin@fitmeal.com
   - **Password**: admin123
4. Click "Sign In"
5. **Expected Result**: Should redirect to admin dashboard

#### Test 2: Simple Admin Credentials
1. Open the app
2. Navigate to login screen
3. Enter credentials:
   - **Email**: admin
   - **Password**: admin123
4. Click "Sign In"
5. **Expected Result**: Should redirect to admin dashboard

#### Test 3: Alternative Admin Credentials
1. Open the app
2. Navigate to login screen
3. Enter credentials:
   - **Email**: admin@example.com
   - **Password**: password
4. Click "Sign In"
5. **Expected Result**: Should redirect to admin dashboard

### 🔍 **What to Verify**

#### Admin Dashboard Access
- ✅ Admin dashboard loads successfully
- ✅ Admin navigation menu appears
- ✅ Admin user data is stored correctly
- ✅ Admin session persists

#### Admin Functionality
- ✅ User management works
- ✅ Recipe management works
- ✅ Analytics dashboard works
- ✅ Admin logout works

### 🚨 **Troubleshooting**

#### If Admin Login Fails

1. **Check Credentials**:
   - Ensure exact spelling and case
   - Try different admin credential combinations
   - Check for extra spaces

2. **Check Network**:
   - Backend API might be down (this is OK - local admin should still work)
   - Local admin should work regardless of API status

3. **Check Session Storage**:
   - Clear app data if needed
   - Restart the app
   - Try logging in again

#### Common Issues

**Issue**: "Invalid credentials" error
- **Solution**: Use one of the supported admin credential combinations

**Issue**: Redirects to user dashboard instead of admin
- **Solution**: Check that you're using admin credentials, not user credentials

**Issue**: App crashes on admin login
- **Solution**: Check that admin dashboard routes are properly configured

### 📱 **Expected User Experience**

#### Successful Admin Login Flow
1. Enter admin credentials
2. Click "Sign In"
3. See "Welcome back, Admin!" message
4. Automatically redirected to admin dashboard
5. Full admin functionality available

#### Admin Dashboard Features
- **Dashboard**: Overview of users, recipes, analytics
- **User Management**: View, edit, delete users
- **Recipe Management**: View, edit, delete recipes
- **Analytics**: View system statistics
- **Logout**: Proper admin session cleanup

### 🔧 **Technical Details**

#### Admin Session Storage
```dart
// Admin session is stored in SharedPreferences
await prefs.setString('admin_token', 'local_admin_token');
await prefs.setString('admin_user', json.encode(userData));
await prefs.setBool('is_admin_logged_in', true);
```

#### Admin Detection Logic
```dart
// Multiple admin credential checks
if ((email == 'admin@fitmeal.com' && password == 'admin123') ||
    (email == 'admin' && password == 'admin123') ||
    (email == 'admin@example.com' && password == 'password')) {
  await _handleLocalAdminLogin();
  return;
}
```

#### Admin Redirect
```dart
// Automatic redirect to admin dashboard
Navigator.pushReplacementNamed(context, '/admin_dashboard');
```

### 🎯 **Success Criteria**

#### ✅ **Admin Login Works When**:
- Any of the 3 admin credential combinations work
- Admin dashboard loads successfully
- Admin session is properly stored
- Admin functionality is accessible
- Admin logout works correctly

#### ❌ **Admin Login Fails When**:
- Wrong credentials are used
- Non-admin credentials are used
- App crashes during login process
- Admin dashboard doesn't load
- Admin session is not stored

### 📋 **Test Checklist**

- [ ] Test admin@fitmeal.com / admin123
- [ ] Test admin / admin123  
- [ ] Test admin@example.com / password
- [ ] Verify admin dashboard loads
- [ ] Verify admin navigation works
- [ ] Verify admin session storage
- [ ] Test admin logout
- [ ] Test regular user login still works
- [ ] Test error handling for wrong credentials

### 🚀 **Quick Test Commands**

#### Test Admin Login (Terminal)
```bash
# Start the app
flutter run

# Test admin credentials in the app:
# 1. admin@fitmeal.com / admin123
# 2. admin / admin123
# 3. admin@example.com / password
```

#### Verify Admin Session
```dart
// Check if admin session is stored
final prefs = await SharedPreferences.getInstance();
final isAdminLoggedIn = prefs.getBool('is_admin_logged_in');
final adminToken = prefs.getString('admin_token');
final adminUser = prefs.getString('admin_user');
```

This test guide ensures that the admin login functionality works correctly and provides troubleshooting steps for common issues.
