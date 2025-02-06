const pages = {
  main: `<h2>Main Page</h2><p>Welcome to the main page.</p>`,
  tasks: `<h2>Tasks Page</h2><p>Here you can manage tasks.</p>`,
  users: `<h2>Users Page</h2><p>List of users will be displayed here.</p>`
};

function showPage(page) {
  document.getElementById('content').innerHTML = pages[page];

  // Remove 'active' class from all links
  document.querySelectorAll('.nav-link').forEach(link => link.classList.remove('active'));

  // Add 'active' class to the clicked link
  event.target.classList.add('active');
}
