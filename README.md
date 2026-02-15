# TinyTunes 🎵

TinyTunes is a kids' video streaming app built with Flutter and Dart.
It works like YouTube Kids, but all content is fully controlled by parents.
The app streams YouTube videos that are manually added and approved by parents using Supabase.

# Features

Parent-controlled YouTube video content.

Organized video categories.

Safe browsing (no open YouTube access).

Supabase backend for managing videos.

Background music on idle screens.

Simple and kid-friendly UI.

# Tech Stack

Flutter

Dart

Supabase

YouTube Player (Embedded)

Audio package for background music

# How It Works

Parent adds a YouTube video link.

The video is stored in Supabase.

The app fetches approved videos.

Kids can watch videos safely inside the app.
 
# Installation

git clone https://github.com/saadsaleem1001/TinyTunes.git

cd tinytunes

flutter pub get

flutter run

Supabase Setup

# Create a videos table with:

id (uuid)

title (text)

youtube_url (text)

category (text)

created_at (timestamp)

Add your Supabase URL and anon key in your service file.

## Future Improvements

Parent authentication system

Screen time control

Offline downloads

Watch history tracking

Favorites section

## 📸 Screenshots

(Add screens![ss1](https://github.com/user-attachments/assets/533a96e1-9693-4f74-a0f8-5bf88c590d89)
![ss2](https://github.com/user-attachments/assets/bd66c9b2-c39b-4b3e-a9f4-8f39803eae29)
hots here)

## 🤝 Contributing

Contributions are welcome!

Fork the repo

Create a new branch

Make changes

Submit a pull request

## Author
Saad Saleem Flutter Developer.....
