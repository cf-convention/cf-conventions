(function(){
  const lsKey = 'theme-mode';
  const darkLink = document.getElementById('theme-dark');
  const lightLink = document.getElementById('theme-light');

  function applyMode(mode) {
    if (mode === 'dark') {
      darkLink.media = 'all';
      lightLink.media = 'not all';
    } else {
      lightLink.media = 'all';
      darkLink.media = 'not all';
    }
  }

  let mode = localStorage.getItem(lsKey);
  if (!mode) {
    mode = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }
  applyMode(mode);

  window.toggleTheme = function(){
    mode = (mode === 'dark' ? 'light' : 'dark');
    applyMode(mode);
    localStorage.setItem(lsKey, mode);
  }
})();
