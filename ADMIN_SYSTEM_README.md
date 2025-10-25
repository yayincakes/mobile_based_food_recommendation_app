# Admin System for Food Recommendation App

## Overview
This admin system provides comprehensive management capabilities for the food recommendation application, including user management, recipe management, and analytics.

## Features

### 🔐 Admin Authentication
- Secure admin login with role-based access control
- Admin middleware protection for all admin routes
- Session management with token-based authentication

### 📊 Dashboard
- Real-time statistics and metrics
- User registration trends
- Recipe and meal plan analytics
- System health monitoring

### 👥 User Management
- View all registered users
- Activate/deactivate user accounts
- Delete user accounts (with admin protection)
- Search and filter users by role and status
- User activity tracking

### 🍽️ Recipe Management
- View all recipes in the system
- Add new recipes with ingredients
- Edit existing recipes
- Delete recipes
- Filter by category and difficulty
- Search functionality

### 📈 Analytics & Reporting
- User registration trends
- Recipe popularity metrics
- Category distribution analysis
- System performance metrics
- Customizable time periods (7, 30, 90 days)

## Backend API Endpoints

### Admin Routes (Protected)
```
GET    /api/admin/dashboard          - Dashboard statistics
GET    /api/admin/analytics          - Analytics data
GET    /api/admin/users              - List users with filters
PUT    /api/admin/users/{id}/status  - Update user status
DELETE /api/admin/users/{id}         - Delete user
GET    /api/admin/recipes            - List recipes with filters
POST   /api/admin/recipes            - Create new recipe
PUT    /api/admin/recipes/{id}       - Update recipe
DELETE /api/admin/recipes/{id}       - Delete recipe
```

## Database Schema Updates

### User Table Additions
```sql
ALTER TABLE users ADD COLUMN role ENUM('user', 'admin') DEFAULT 'user';
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT true;
```

## Setup Instructions

### 1. Database Migration
```bash
cd backend_food_recommendation_app
php artisan migrate
```

### 2. Seed Admin User
```bash
php artisan db:seed --class=AdminUserSeeder
```

### 3. Default Admin Credentials
- **Email**: admin@fitmeal.com
- **Password**: admin123

### 4. Access Admin Panel
1. Open the Flutter app
2. Go to Profile screen
3. Tap "Admin Access" button
4. Login with admin credentials

## Security Features

### 🔒 Role-Based Access Control
- Admin middleware protects all admin routes
- Only users with `role = 'admin'` can access admin features
- Inactive admin accounts are blocked

### 🛡️ Data Protection
- Admin users cannot be deleted
- User status changes are logged
- Secure token-based authentication

## Flutter Admin Screens

### AdminLoginScreen
- Secure login form with validation
- Role verification
- Session management

### AdminDashboardScreen
- Overview statistics
- Quick action buttons
- System health indicators

### AdminUsersScreen
- User list with search and filters
- Status management (activate/deactivate)
- User deletion (non-admin only)

### AdminRecipesScreen
- Recipe management interface
- Category and difficulty filters
- CRUD operations for recipes

### AdminAnalyticsScreen
- Data visualization
- Trend analysis
- Performance metrics

## API Integration

The admin system uses the enhanced `ApiService` class with:
- Automatic token management
- Error handling
- Response parsing
- HTTP method abstraction (GET, POST, PUT, DELETE)

## Future Enhancements

### 📊 Advanced Analytics
- Chart.js integration for data visualization
- Export functionality for reports
- Custom date range selection

### 🔔 Notifications
- Real-time admin notifications
- System alerts
- User activity notifications

### 📱 Mobile Optimization
- Responsive design for tablets
- Touch-friendly interface
- Offline capability

### 🔧 System Settings
- Application configuration
- Feature toggles
- Maintenance mode

## Development Notes

### Code Structure
```
lib/screens/admin/
├── admin_login_screen.dart
├── admin_dashboard_screen.dart
├── admin_users_screen.dart
├── admin_recipes_screen.dart
└── admin_analytics_screen.dart
```

### Backend Structure
```
backend_food_recommendation_app/
├── app/Http/Controllers/AdminController.php
├── app/Http/Middleware/AdminMiddleware.php
├── database/migrations/
│   └── add_admin_role_to_users_table.php
└── database/seeders/AdminUserSeeder.php
```

## Testing

### Manual Testing
1. Login with admin credentials
2. Navigate through all admin screens
3. Test user management functions
4. Verify recipe operations
5. Check analytics data

### Security Testing
1. Try accessing admin routes without authentication
2. Test with non-admin user credentials
3. Verify middleware protection
4. Test session management

## Troubleshooting

### Common Issues
1. **Admin login fails**: Check database migration and seeder
2. **API errors**: Verify backend server is running
3. **Permission denied**: Check user role in database
4. **Token expired**: Clear app data and re-login

### Debug Steps
1. Check Laravel logs: `storage/logs/laravel.log`
2. Verify database connection
3. Check API endpoint responses
4. Validate token in SharedPreferences

## Support

For issues or questions about the admin system:
1. Check the troubleshooting section
2. Review API documentation
3. Check Laravel and Flutter logs
4. Verify database schema and data
