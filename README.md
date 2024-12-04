## 2007004 
### Polok's Work(User Registration) 
This SwiftUI view implements the **sign-up screen** for the `BookMyStay` app. It features a visually engaging interface with gradients and glowing effects. The screen allows users to register by entering their name, email, and password.
It integrates Firebase Authentication to create new user accounts and stores user data (name, email, password) in Firestore for future use. A `placeholder` modifier enhances the text fields with dynamic hints when fields are empty.

<img width="364" alt="Screenshot 2024-12-04 at 11 29 26 PM" src="https://github.com/user-attachments/assets/ea985e79-fccd-4f74-8a11-d6df3fc6a4f1">


## 2007020 
### Hasib's Work(User Login) 
This SwiftUI view provides the **login screen** for the `BookMyStay` app, enabling users to log in with their email and password. It uses Firebase Authentication to validate user credentials and retrieves user-specific 
data from Firestore upon successful login. The interface includes a gradient background, dynamic placeholders, and error handling to display feedback when login fails. On successful login, users are navigated 
to the home screen (`HotelFormView`).

<img width="372" alt="Screenshot 2024-12-04 at 11 29 40 PM" src="https://github.com/user-attachments/assets/8b0c2fbf-9810-41b6-8e70-5a46f5074a36">

## 2007001 
### Peyal's Work(Data store and fetch from Firestore Database) 
The `HotelFormView` allows users to add new hotels to the database, capturing details such as name, location, rating, reviews, capacity, amenities, and an image URL. It validates user inputs and saves the data to Firebase Firestore. 
On successful submission, the form resets for new entries.  

The `HotelListView` fetches hotel data from Firestore and displays it in a list. Each hotel entry includes an image, name, location, rating, and reviews. The list updates automatically upon appearance,
with a loading indicator shown during data retrieval. This view ensures a clean and dynamic presentation of stored hotel records.
<img width="365" alt="Screenshot 2024-12-04 at 11 19 24 PM" src="https://github.com/user-attachments/assets/a4d5403f-f564-4584-87ce-e513e1a871ab">
<img width="369" alt="Screenshot 2024-12-04 at 11 21 08 PM" src="https://github.com/user-attachments/assets/7636290f-cdec-4ea4-b010-0dbd951b6803">
