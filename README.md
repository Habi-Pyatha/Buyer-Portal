# Buyer Portal

A real-estate buyer portal with user authentication and property favorites.

## Features

- User registration and login (email + password)
- Session-style authentication via Devise
- Browse properties
- Add/remove properties from favorites
- User dashboard showing favorites
- Admin panel for managing properties (CRUD)
- Dark mode toggle (persists in localStorage)
- Users can only see and modify their own favorites

## Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Set up the database:
   ```bash
   rails db:migrate
   rails db:seed
   ```

3. Start the server:
   ```bash
   rails server
   ```

4. Open http://localhost:3000

## Example Flows

### Sign Up → Login → Add Favourite

1. **Sign Up**: Click "Sign up" on the login page. Enter your email and password (minimum 6 characters). Submit to create your account.

2. **Login**: Use the email and password you just created to log in.

3. **Browse Properties**: You'll be redirected to the properties list. Click on any property to view details.

4. **Add Favourite**: On a property detail page, click "Add to Favourites". The button will change to "Remove from Favourites".

5. **View Dashboard**: Click "Dashboard" in the navigation to see your saved favorites. You can remove favorites from this page.

### Admin Features

To access admin features, you need to set a user as admin:

```bash
rails runner "User.find_by(email: 'your-email@example.com').update(role: 'admin')"
```

Or create a new admin user:

```bash
rails runner "User.create!(email: 'admin@example.com', password: 'password123', password_confirmation: 'password123', role: 'admin')"
```

Once you have an admin account:
1. Log in with the admin account
2. Click "Admin" in the navigation bar
3. You can now:
   - View all properties
   - Add new properties
   - Edit existing properties
   - Delete properties

### Dark Mode

- Click the moon/sun icon in the navigation bar to toggle dark mode
- Your preference is saved in localStorage and persists across sessions

### Notes

- Users can only see their own favorites in the dashboard
- Favorites are unique per user-property combination (no duplicate favorites)
- The application includes 5 sample properties seeded in the database
- Logout is available in the navigation bar
- Admin link only appears for users with admin role

## Tech Stack

- Rails 8.1
- Devise for authentication
- SQLite database
- Tailwind CSS 2.x for styling
