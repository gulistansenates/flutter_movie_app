import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:provider/provider.dart';
import '../view/widget/movie_card.dart';
import '../theme/theme_provider.dart';

class MovieHomePage extends StatefulWidget {
  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  String selectedCategory = 'All';
  String searchQuery = '';

  final List<String> categories = [
    'All',
    'Action',
    'Comedy',
    'Drama',
    'Sci-Fi'
  ];

  List<Movie> allMovies = [
    Movie(
      id: 1,
      title: 'Action Movie',
      overview: 'An action-packed movie',
      posterPath: '', /* add category if needed */
    ),
    Movie(
        id: 2,
        title: 'Comedy Movie',
        overview: 'A funny movie',
        posterPath: ''),
    Movie(
        id: 3, title: 'Drama Movie', overview: 'A drama movie', posterPath: ''),
  ];

  List<Movie> get filteredMovies {
    var filtered = selectedCategory == 'All'
        ? allMovies
        : allMovies
            .where((movie) => movie.title.contains(selectedCategory))
            .toList();

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((movie) =>
              movie.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              value: selectedCategory,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              dropdownColor: Colors.blue,
              underline: SizedBox(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items:
                  categories.map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search movies...',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          final movie = filteredMovies[index];
          return MovieCard(
            movie: movie,
            onTap: () {},
          );
        },
      ),
    );
  }
}
