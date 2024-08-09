module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'grey': '#F0F0F0',
        'dark-grey': '#858585',
        'fire': '#f08030',
        'water': '#6890f0',
        'grass': '#78c850',
        'electric': '#f8d030'
      }
    }
  }
}
